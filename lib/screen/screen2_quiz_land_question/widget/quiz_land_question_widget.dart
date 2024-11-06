import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_wrap/conditional_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:local_hero/local_hero.dart';
import 'package:quizland_calculator/app/app.locator.dart';
import 'package:quizland_calculator/app/data/question.dart';
import 'package:quizland_calculator/app/utils.dart';
import 'package:quizland_calculator/screen/screen2_quiz_land_question/bloc/quiz_land_question_bloc.dart';
import 'package:quizland_calculator/screen/screen2_quiz_land_question/bloc/quiz_land_question_event.dart';
import 'package:quizland_calculator/screen/screen2_quiz_land_question/bloc/quiz_land_question_state.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../quiz_land_question_param.dart';

class QuizLandQuestionWidget extends StatefulWidget {
  final ParentScreenInfo parentScreenInfo;
  const QuizLandQuestionWidget({super.key, required this.parentScreenInfo});

  @override
  State<QuizLandQuestionWidget> createState() => _QuizLandQuestionWidgetState();
}

class _QuizLandQuestionWidgetState extends State<QuizLandQuestionWidget> {
  late VideoPlayerController _controller;
  final ValueNotifier<bool> _isControllerInit = ValueNotifier(false);
  late QuizLandQuestionBloc bloc;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<QuizLandQuestionBloc>();
    _isControllerInit.value = false;
    bloc.setVideoTypeListener((video) {
      try {
        _controller = VideoPlayerController.asset(video.videoFile)
          ..initialize().then((_) {
            _isControllerInit.value = true;
          });
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    QuizLandQuestionBloc bloc = context.read<QuizLandQuestionBloc>();
    Container container = widget.parentScreenInfo.widgetMap[bloc.type] as Container;
    ConstraintId guideline1 = ConstraintId('guideline1');
    ConstraintId guideline2 = ConstraintId('guideline2');
    ConstraintId header = ConstraintId('header');
    final screenSize = MediaQuery.of(context).size;
    return ConstraintLayout(
      children: [
        BlocBuilder<QuizLandQuestionBloc, QuizLandQuestionState>(builder: (context, state) {
          Widget? text;
          if (state == QuizLandQuestionState.videoPickOption ||
              state == QuizLandQuestionState.showIsAnswerCorrectOrNot ||
              state == QuizLandQuestionState.goBackWithHeroAnimation) {
            return Container();
          }
          if (state == QuizLandQuestionState.video) {
            text = bloc.question?.context.video.headerText
                .let((it) => Center(child: Text(it, style: const TextStyle(fontSize: 20, color: Colors.white))));
          }
          return Stack(
            children: [
              WidgetWrapper(
                wrapper: (child) => state.heroState.isHeroEnable ? Hero(tag: bloc.id, child: child) : child,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, bottom: 50.0),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      opacity: state.headerBackgroundOpacity,
                      child: Container(
                        color: container.color,
                      ),
                    ),
                  ),
                ),
              ),
              if (text != null)
                Positioned.fill(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, bottom: 50.0),
                  child: text,
                )),
              Positioned.fill(
                  child: Row(
                children: [
                  WidgetWrapper(
                    wrapper: (child) => state.heroState.isLocalHeroEnable ? LocalHero(tag: "hat", child: child) : child,
                    child: WidgetWrapper(
                      wrapper: (child) => state.heroState.isHeroEnable ? Hero(tag: "hat", child: child) : child,
                      child: WidgetCircularAnimator(
                        size: 50,
                        innerIconsSize: 3,
                        outerIconsSize: 3,
                        innerAnimation: Curves.easeInOutBack,
                        outerAnimation: Curves.easeInOutBack,
                        innerColor: Colors.deepPurple,
                        outerColor: Colors.blue.shade700,
                        innerAnimationSeconds: 10,
                        outerAnimationSeconds: 10,
                        child: Container(
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
                          child: Image.asset(
                            'assets/harry_potter/hat.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              )),
            ],
          );
        }).applyConstraint(
          width: wrapContent,
          height: wrapContent,
          centerTo: header,
          zIndex: 20,
        ),
        Container(
          color: const Color(0xFF2b2b2b),
        ).applyConstraint(
          id: header,
          width: matchParent,
          height: matchConstraint,
          top: parent.top,
          bottom: guideline1.top,
          zIndex: 10,
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
        BlocBuilder<QuizLandQuestionBloc, QuizLandQuestionState>(builder: (context, state) {
          Widget? widget;
          if (state == QuizLandQuestionState.videoPickOption ||
              state == QuizLandQuestionState.showIsAnswerCorrectOrNot ||
              state == QuizLandQuestionState.goBackWithHeroAnimation) {
            PickedItem pickItem = bloc.pickedItem!;
            String wrongOrCorrect = (bloc.isPickedOptionCorrect ?? false) ? "Correct!" : "Wrong!";
            MaterialColor answerColor = (bloc.isPickedOptionCorrect ?? false) ? Colors.green : Colors.red;
            widget = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Stack(
                    children: [
                      if (state == QuizLandQuestionState.showIsAnswerCorrectOrNot ||
                          state == QuizLandQuestionState.goBackWithHeroAnimation)
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, bottom: 58.0),
                          child: Center(
                              child: Container(
                                  color: answerColor.withAlpha(50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text(wrongOrCorrect, style: const TextStyle(fontSize: 20, color: Colors.white)),
                                  ))),
                        ),
                      WidgetWrapper(
                        wrapper: (child) =>
                            state.heroState.isLocalHeroEnable ? LocalHero(tag: "hat", child: child) : child,
                        child: WidgetWrapper(
                          wrapper: (child) => state.heroState.isHeroEnable ? Hero(tag: "hat", child: child) : child,
                          child: WidgetCircularAnimator(
                            size: 50,
                            innerIconsSize: 3,
                            outerIconsSize: 3,
                            innerAnimation: Curves.easeInOutBack,
                            outerAnimation: Curves.easeInOutBack,
                            innerColor: Colors.deepPurple,
                            outerColor: Colors.blue.shade700,
                            innerAnimationSeconds: 10,
                            outerAnimationSeconds: 10,
                            child: Container(
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
                              child: Image.asset(
                                'assets/harry_potter/hat.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: WidgetWrapper(
                    wrapper: (child) =>
                        state.heroState.isLocalHeroEnable ? LocalHero(tag: "pickedItem", child: child) : child,
                    child: Container(
                      width: 170,
                      height: 150,
                      color: pickItem.color.withAlpha(150),
                      child: Center(
                        child: AutoSizeText(
                          textAlign: TextAlign.center,
                          pickItem.text,
                          minFontSize: 12,
                          style: const TextStyle(fontSize: 22, color: Colors.white, height: 0.95),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Container(
            color: const Color(0xFF2b2b2b),
            child: widget,
          );
        }).applyConstraint(
          width: matchParent,
          height: matchConstraint,
          top: guideline2.bottom,
          bottom: parent.bottom,
        ),
        BlocBuilder<QuizLandQuestionBloc, QuizLandQuestionState>(builder: (context, state) {
          Widget? video;
          if (state.showVideoPlayer) {
            video = VideoPlayerWrapper(
              isLocalHeroEnable: state.heroState.isLocalHeroEnable,
              controller: _controller,
              isControllerInit: _isControllerInit,
              options: bloc.question?.context.video.options ?? [],
              playTime: bloc.question?.context.video.pauseTime ?? 1000,
              isStartLocalHeroAnimation: state == QuizLandQuestionState.videoPickOption ||
                  state == QuizLandQuestionState.showIsAnswerCorrectOrNot ||
                  state == QuizLandQuestionState.goBackWithHeroAnimation,
            );
          }
          return Container(
            color: Colors.black,
            child: video,
          );
        }).applyConstraint(
          width: matchParent,
          height: matchConstraint,
          top: guideline1.bottom,
          bottom: guideline2.top,
        ),
      ],
    );
  }
}

class VideoPlayerWrapper extends StatefulWidget {
  final VideoPlayerController controller;
  final ValueNotifier<bool> isControllerInit;
  final int playTime;
  final List<QuestionOption> options;
  final bool isLocalHeroEnable;
  final bool isStartLocalHeroAnimation;

  const VideoPlayerWrapper(
      {super.key,
      required this.controller,
      required this.isControllerInit,
      required this.playTime,
      required this.options,
      required this.isLocalHeroEnable,
      required this.isStartLocalHeroAnimation});

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
      if (context.mounted) {
        setState(() {
          if (context.mounted) {
            widget.controller.pause();
          }
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
                        QuizLandQuestionBloc bloc = context.read<QuizLandQuestionBloc>();
                        bloc.add(PickedOptionEvent(optionIndex: index, color: color, text: widget.options[index].text));
                        await wait(seconds: 3);
                        bool isCorrect = widget.options[index].isRight;
                        if (context.mounted) {
                          setState(() {
                            if (context.mounted) {
                              widget.controller.play();
                              widget.controller.addListener(() async {
                                if (!_isVideoAlreadyCompleted && widget.controller.isVideoEnd()) {
                                  _isVideoAlreadyCompleted = true;
                                  bloc.add(GoBackWithHeroAnimationEvent());
                                  await wait(milliseconds: 300);
                                  Di.routeMediator.goBack(isCorrect);
                                }
                              });
                            }
                          });
                        }
                        await wait(seconds: 5);
                        bloc.add(ShowIsAnswerCorrectOrNotEvent(isCorrect: isCorrect));
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

typedef IntCallback = void Function(int index);

class QuestionOptionItem extends StatelessWidget {
  final Color backgroundColor;
  final List<String> texts;
  final IntCallback onItemClick;
  final int index;
  final bool isPicked;
  final bool hasAnyPickedOption;
  final bool isLocalHeroEnable;

  const QuestionOptionItem(
      {super.key,
      required this.backgroundColor,
      required this.texts,
      required this.onItemClick,
      required this.index,
      required int pickedOption,
      required this.isLocalHeroEnable})
      : isPicked = (pickedOption == index),
        hasAnyPickedOption = (pickedOption != -1);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: WidgetWrapper(
          wrapper: (child) => isLocalHeroEnable && isPicked ? LocalHero(tag: "pickedItem", child: child) : child,
          child: GestureDetector(
            onTap: () => onItemClick.call(index),
            child: AnimatedOpacity(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
              opacity: (hasAnyPickedOption && !isPicked) ? 0 : 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: backgroundColor.withAlpha(isPicked ? 150 : 125),
                child: Center(
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    texts[index],
                    minFontSize: 12,
                    style: const TextStyle(fontSize: 22, color: Colors.white, height: 0.95),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

typedef PickedOption = void Function(int index, Color color);

class QuestionWithOptionsWidget extends StatefulWidget {
  final List<QuestionOption> options;
  final PickedOption onPickOption;
  final bool isLocalHeroEnable;

  const QuestionWithOptionsWidget({
    super.key,
    required this.options,
    required this.onPickOption,
    required this.isLocalHeroEnable,
  });

  @override
  State<QuestionWithOptionsWidget> createState() => _QuestionWithOptionsWidgetState();
}

class _QuestionWithOptionsWidgetState extends State<QuestionWithOptionsWidget> {
  int pickedOption = -1;
  @override
  Widget build(BuildContext context) {
    List<String> options = widget.options.map((element) => element.text).toList();
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: [
              QuestionOptionItem(
                  backgroundColor: Colors.green,
                  index: 0,
                  texts: options,
                  onItemClick: (i) {
                    setState(() => pickedOption = i);
                    widget.onPickOption.call(i, Colors.green);
                  },
                  isLocalHeroEnable: widget.isLocalHeroEnable,
                  pickedOption: pickedOption),
              QuestionOptionItem(
                  backgroundColor: Colors.blue,
                  index: 1,
                  texts: options,
                  onItemClick: (i) {
                    setState(() => pickedOption = i);
                    widget.onPickOption.call(i, Colors.blue);
                  },
                  isLocalHeroEnable: widget.isLocalHeroEnable,
                  pickedOption: pickedOption),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              QuestionOptionItem(
                  backgroundColor: Colors.yellow,
                  index: 2,
                  texts: options,
                  onItemClick: (i) {
                    setState(() => pickedOption = i);
                    widget.onPickOption.call(i, Colors.yellow);
                  },
                  isLocalHeroEnable: widget.isLocalHeroEnable,
                  pickedOption: pickedOption),
              QuestionOptionItem(
                  backgroundColor: Colors.red,
                  index: 3,
                  texts: options,
                  onItemClick: (i) {
                    setState(() => pickedOption = i);
                    widget.onPickOption.call(i, Colors.red);
                  },
                  isLocalHeroEnable: widget.isLocalHeroEnable,
                  pickedOption: pickedOption),
            ],
          ),
        ),
      ],
    );
  }
}
