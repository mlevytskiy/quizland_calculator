import 'package:core/src/app/data/impl/question_option.dart';
import 'package:core/src/app/data/impl/question_video.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_side_effect/flutter_bloc_side_effect.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:video_player/video_player.dart';

import 'impl/hat_widget.dart';
import 'impl/hero_data.dart';
import 'impl/video_player_wrapper.dart';

part 'video_widget.style.dart';

class VideoWidget extends StatefulWidget {
  final Color textBackgroundColor;
  final HeroData heroData;
  final VideoQuizLandQuestionState blocState;

  const VideoWidget({super.key, required this.textBackgroundColor, required this.heroData, required this.blocState});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late QuestionVideo _video;
  final ValueNotifier<bool> _isControllerInit = ValueNotifier(false);
  QuestionOption? pickedOption;
  bool _isStartLocalHeroAnimation = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _video = widget.blocState.video;
    _isControllerInit.value = false;
    try {
      _controller = VideoPlayerController.asset(_video.videoFile)
        ..initialize().then((_) {
          _isControllerInit.value = true;
        });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ConstraintId guideline1 = ConstraintId('guideline1');
    ConstraintId guideline2 = ConstraintId('guideline2');
    ConstraintId header = ConstraintId('header');
    ConstraintId footer = ConstraintId('footer');
    return ConstraintLayout(
      children: [
        VideoScreenColors.topBackground.container().applyConstraint(
              id: header,
              width: matchParent,
              height: matchConstraint,
              top: parent.top,
              bottom: guideline1.top,
              zIndex: 10,
            ),
        HatWidget(
          isHeroEnable: widget.heroData.mode.isHeroEnable,
          isLocalHeroEnable: widget.heroData.mode.isLocalHeroEnable,
          heroTextTag: widget.heroData.heroTag2ForText,
          heroHatTag: widget.heroData.heroTag,
          localHeroTag: widget.heroData.localHeroTag,
          textBackgroundOpacity: 0.3,
          textBackgroundColor: widget.textBackgroundColor,
          textBoxWidth: 300,
          textBoxHeight: 50,
          message: widget.blocState.video.headerText,
        ).visible(pickedOption == null).applyConstraint(
              bottomCenterTo: header,
              margin: const EdgeInsets.only(bottom: 15),
              zIndex: 11,
            ),
        Guideline(
          id: guideline1,
          horizontal: true,
          guidelinePercent: 0.3,
        ),
        Guideline(
          id: guideline2,
          horizontal: true,
          guidelinePercent: 0.7,
        ),
        VideoScreenColors.middlePartBackground
            .container(
                child: VideoPlayerWrapper(
              controller: _controller,
              isControllerInit: _isControllerInit,
              playTime: _video.pauseTime,
              options: _video.options,
              isLocalHeroEnable: true,
              isStartLocalHeroAnimation: _isStartLocalHeroAnimation,
              onPick: (option) {
                setState(() {
                  _isStartLocalHeroAnimation = true;
                  pickedOption = option;
                });
              },
              onVideoEnd: () {
                _bloc().emitSideEffect(CloseScreenSideEffect(pickedOption?.isRight ?? false));
              },
            ))
            .applyConstraint(
              width: matchParent,
              height: matchConstraint,
              top: guideline1.bottom,
              bottom: guideline2.top,
            ),
        VideoScreenColors.bottomBackground
            .container(
              child: HatWidget(
                isHeroEnable: widget.heroData.mode.isHeroEnable,
                isLocalHeroEnable: widget.heroData.mode.isLocalHeroEnable,
                heroTextTag: widget.heroData.heroTag2ForText,
                heroHatTag: widget.heroData.heroTag,
                localHeroTag: widget.heroData.localHeroTag,
                textBackgroundOpacity: 0.3,
                textBackgroundColor: (pickedOption?.isRight ?? false) ? Colors.green : Colors.red,
                textBoxWidth: 150,
                textBoxHeight: 50,
                message: (pickedOption?.isRight ?? false) ? "Correct!" : "Wrong!",
              ).visible(pickedOption != null).center(),
            )
            .applyConstraint(
              width: matchParent,
              height: matchConstraint,
              top: guideline2.bottom,
              bottom: parent.bottom,
              id: footer,
            ),
      ],
    );
  }

  QuizLandQuestionBloc _bloc() => context.read<QuizLandQuestionBloc>();
}
