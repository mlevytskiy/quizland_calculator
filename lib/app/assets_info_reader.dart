import 'package:flutter/services.dart' show rootBundle;

Future<Question> readAssets(String path) async {
  String fileStr = await rootBundle.loadString(path);

  return Question();
}

class Question {}
