import 'package:conditional_wrap/conditional_wrap.dart';
import 'package:core/src/app/app.locator.dart';
import 'package:core/src/screen/screen1_quiz_land/bloc/quiz_land_bloc.dart';
import 'package:core/src/widget/grid_view_builder.dart';
import 'package:core/src/widget/harry_potter_button/harry_potter_button.dart';
import 'package:core/src/widget/harry_potter_button/harry_potter_button_callback.dart';
import 'package:core/src/widget/harry_potter_button/harry_potter_button_state.dart';
import 'package:core/src/widget/harry_potter_button/hero_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';

import '../bloc/quiz_land_state.dart';

class QuizLandWidget extends StatefulWidget {
  final QuizLandState quizLandState;

  const QuizLandWidget({super.key, required this.quizLandState});

  @override
  State<QuizLandWidget> createState() => _QuizLandWidgetState();
}

class _QuizLandWidgetState extends State<QuizLandWidget> {
  @override
  Widget build(BuildContext context) {
    GridViewBuilder builder = GridViewBuilder()
      ..set2DArrayStr('''
                        .. .. 1a .. ..
                        .. .. 3b .. 3c
                        .. .. 3d 3e 3f
                        .. 3g 3h .. 2i
                        3j 2k 3l 2m 3n
                        1o .. 3p 1q ..
                        3r 3s 2t .. ..
                        .. .. 1u .. ..
                        .. .. 2v .. ..
                ''')
      ..addWidget(
          "1",
          Container(
            color: Colors.red,
          ))
      ..addWidget(
          "2",
          Container(
            color: Colors.green,
          ))
      ..addWidget(
          "3",
          Container(
            color: Colors.yellow,
          ));
    QuizLandBloc bloc = context.read<QuizLandBloc>();
    GridViewParam gridViewParam = (builder
          ..setQuizResult(bloc.quizResult)
          ..setItemClickListener((id, type) async {
            bool? result = await Di.routeMediator.goQuestionForResult(id, type, builder.widgetMap);
            setState(() {
              bloc.quizResult[id] = result;
              if (!Di.audioPlayer.playing) {
                Di.audioPlayer.setVolume(0.02);
                Di.audioPlayer.play();
              }
              print("testr result=$result");
            });
          }))
        .build();
    return ConstraintLayout(
      childConstraints: [
        Constraint(
          id: ConstraintId("header"),
          topCenterTo: parent,
          zIndex: 20,
        ),
        Constraint(
          id: ConstraintId("grid"),
          top: cId("header").bottom,
          right: parent.right,
          left: parent.left,
          horizontalBias: 0.47,
          // visibility: (QuizLandState.showHeaderTextPhase2AndGrid == quizLandState)
          //     ? CLVisibility.visible
          //     : CLVisibility.invisible,
          zIndex: 20,
        ),
        Constraint(
          id: cId("background"),
          // top: parent.top,
          // bottom: parent.bottom,
          // right: parent.right,
          // left: parent.left,
          height: matchParent,
          width: matchParent,
          zIndex: 19,
        ),
        Constraint(
          id: cId("hat"),
          bottom: parent.bottom,
          top: cId("grid").center,
          right: cId("grid").center,
          left: parent.left,
          horizontalBias: 0.3,
          verticalBias: 0.8,
          zIndex: 21,
        )
      ],
      children: [
        (HarryPotterButtonBuilder()..setQuizLandState(widget.quizLandState))
            .build()
            .applyConstraintId(id: ConstraintId("header")),
        WidgetWrapper(
            wrapper: (child) => (widget.quizLandState == QuizLandState.showHeaderTextPhase2AndGrid)
                ? Hero(tag: "hat", child: child)
                : child,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  bloc.quizResult.clear();
                });
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
                  child: Image.asset(
                    'assets/harry_potter/hat.png',
                  ),
                ),
              ),
            )).applyConstraintId(id: cId("hat")),
        AnimatedOpacity(
            opacity: (QuizLandState.showHeaderTextPhase2AndGrid == widget.quizLandState) ? 0.8 : 0.0,
            duration: const Duration(seconds: 1),
            curve: Curves.bounceIn,
            child: ConstraintLayout(
                width: wrapContent,
                height: wrapContent,
                children: constraintGrid(
                    id: ConstraintId('grid0'),
                    left: parent.left,
                    top: parent.top,
                    itemCount: gridViewParam.widgets.length,
                    columnCount: gridViewParam.columnCount,
                    itemWidth: 42,
                    itemHeight: 42,
                    itemBuilder: (index, rowIndex, columnIndex) {
                      return gridViewParam.widgets[index];
                    },
                    itemMarginBuilder: (index, rowIndex, columnIndex) {
                      return const EdgeInsets.only(
                        left: 5,
                        top: 5,
                      );
                    }))).applyConstraintId(id: ConstraintId("grid")),
        Container(color: Colors.black, child: const Image(image: AssetImage('assets/hogwards_express.png')))
            .applyConstraintId(id: cId("background")),
      ],
    );
  }
}

class HarryPotterButtonBuilder {
  late HeroState _heroState;
  late HarryPotterButtonState _state;

  void setQuizLandState(QuizLandState quizLandState) {
    if (quizLandState == QuizLandState.heroMode) {
      _heroState = HeroState.betweenScreens;
      _state = HarryPotterButtonState.circleButton;
    } else if (quizLandState == QuizLandState.localHeroMode) {
      _heroState = HeroState.localHero;
      _state = HarryPotterButtonState.circleButton;
    } else if (quizLandState == QuizLandState.transformCircleToRectanglePhase1) {
      _heroState = HeroState.localHero;
      _state = HarryPotterButtonState.rectangleHeader;
    } else if (quizLandState == QuizLandState.showHeaderTextPhase1) {
      _heroState = HeroState.localHero;
      _state = HarryPotterButtonState.rectangleHeaderWithText;
    } else {
      _heroState = HeroState.localHero;
      _state = HarryPotterButtonState.rectangleHeaderWithRightText;
    }
  }

  void setCallback(HarryPotterButtonCallback callback) {}

  HarryPotterButton build() {
    return HarryPotterButton(
      heroState: _heroState,
      state: _state,
      callback: HarryPotterButtonCallback(localHeroAnimationCallback: (tag) {}),
    );
  }
}