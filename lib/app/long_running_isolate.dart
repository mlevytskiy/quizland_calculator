import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:async/async.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quizland_calculator/app/data/question.dart';

class YAJsonIsolate {
  final _receivePort = ReceivePort();
  late final SendPort _sendPort;
  final _createdIsolate = Completer<void>();
  late final _events = StreamQueue(_receivePort);
  bool _hasStartedInitialize = false;

  /// Initialize the isolate
  ///
  /// This method is called automatically when the first method is called. Manually initializing before first json de/encode can improve performance.
  Future<void> initialize() async {
    assert(_hasStartedInitialize == false, 'initialize() can only be called once per isolate.');
    _hasStartedInitialize = true;
    await Isolate.spawn(
      _compute,
      _receivePort.sendPort,
      onExit: _receivePort.sendPort,
      onError: _receivePort.sendPort,
    );
    _sendPort = await _events.next;
    _createdIsolate.complete();
  }

  /// Dispose the isolate
  ///
  /// This exists the isolate
  Future<void> dispose() async {
    await _createdIsolate.future;
    _sendPort.send(null);
    _receivePort.close();
    await _events.cancel();
  }

  Future<Question> decode(String filePath) async {
    if (!_createdIsolate.isCompleted) {
      if (!_hasStartedInitialize) initialize();
      await _createdIsolate.future;
    }
    _sendPort.send([await rootBundle.loadString(filePath), false]);
    Question question = await _handleRes(await _events.next);
    return question;
  }

  Future<Question> _handleRes(List response) async {
    final int type = response.length;
    assert(1 <= type && type <= 3);

    switch (type) {
      // success; see _buildSuccessResponse
      case 1:
        return response[0] as Question;

      // native error; see Isolate.addErrorListener
      case 2:
        await Future<Never>.error(RemoteError(
          response[0] as String,
          response[1] as String,
        ));

      // caught error; see _buildErrorResponse
      case 3:
      default:
        assert(type == 3 && response[2] == null);

        await Future<Never>.error(
          response[0] as Object,
          response[1] as StackTrace,
        );
    }
  }
}

void _compute(SendPort p) async {
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  await for (final event in commandPort) {
    if (event is List) {
      var input = event.first;

      final bool method = event.last;
      late final List<dynamic> computationResult;

      try {
        final dynamic res;
        if (method == true) {
          res = jsonEncode(input);
          computationResult = _buildSuccessResponse(res);
        } else {
          res = jsonDecode(input);
          computationResult = _buildSuccessResponse(Question.fromJson(res));
        }
      } catch (e, s) {
        computationResult = _buildErrorResponse(e, s);
      }

      p.send(computationResult);
    } else if (event == null) {
      break;
    }
  }
  Isolate.exit();
}

/// Wrap in [List] to ensure our expectations in the main [Isolate] are met.
///
/// We need to wrap a success result in a [List] because the user provided type
/// [R] could also be a [List]. Meaning, a check `result is R` could return true
/// for what was an error event.
List<R> _buildSuccessResponse<R>(R result) {
  return List<R>.filled(1, result);
}

/// Wrap in [List] to ensure our expectations in the main isolate are met.
///
/// We wrap a caught error in a 3 element [List]. Where the last element is
/// always null. We do this so we have a way to know if an error was one we
/// caught or one thrown by the library code.
List<dynamic> _buildErrorResponse(Object error, StackTrace stack) {
  return List<dynamic>.filled(3, null)
    ..[0] = error
    ..[1] = stack;
}
