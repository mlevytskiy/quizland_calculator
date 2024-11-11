import 'package:core/src/app/data/question.dart';
import 'package:core/src/app/utils.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/impl/question_with_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef OnPick = void Function(QuestionOption option);

class VideoPlayerWrapper extends StatefulWidget {
  final VideoPlayerController controller;
  final ValueNotifier<bool> isControllerInit;
  final int playTime;
  final List<QuestionOption> options;
  final bool isLocalHeroEnable;
  final bool isStartLocalHeroAnimation;
  final OnPick onPick;
  final VoidCallback onVideoEnd;

  const VideoPlayerWrapper({
    super.key,
    required this.controller,
    required this.isControllerInit,
    required this.playTime,
    required this.options,
    required this.isLocalHeroEnable,
    required this.isStartLocalHeroAnimation,
    required this.onPick,
    required this.onVideoEnd,
  });

  @override
  State<VideoPlayerWrapper> createState() => _VideoPlayerWrapperState();
}

class _VideoPlayerWrapperState extends State<VideoPlayerWrapper> {
  bool _isVideoAlreadyCompleted = false; //prevent double call;

  @override
  void initState() {
    super.initState();
    if (widget.controller.value.isInitialized) {
      playVideoAndPauseItOnPlaceWithQuestion();
    } else {
      widget.isControllerInit.addListener(
          () => playVideoAndPauseItOnPlaceWithQuestion(isVideoControllerInit: widget.isControllerInit.value));
    }
  }

  void playVideoAndPauseItOnPlaceWithQuestion({bool isVideoControllerInit = true}) async {
    if (isVideoControllerInit) {
      setState(() {
        widget.controller.play();
      });
      await wait(milliseconds: widget.playTime);
      if (mounted) {
        setState(() {
          widget.controller.pause();
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.controller.value.isInitialized
          ? Stack(
              children: [
                AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
                Positioned.fill(
                  child: Visibility(
                    visible: !widget.controller.value.isPlaying && !widget.isStartLocalHeroAnimation,
                    child: QuestionWithOptionsWidget(
                      isLocalHeroEnable: widget.isLocalHeroEnable,
                      options: widget.options,
                      onPickOption: (int index, Color color) async {
                        widget.onPick(widget.options[index]);
                        widget.controller.play();
                        widget.controller.addListener(() async {
                          if (!_isVideoAlreadyCompleted && widget.controller.isVideoEnd()) {
                            _isVideoAlreadyCompleted = true;
                            widget.onVideoEnd();
                          }
                        });
                      },
                    ),
                    // child: Container(color: Colors.white54),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
