import 'package:core/src/app/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/data/question.dart';
import 'quiz_land_question_event.dart';
import 'quiz_land_question_state.dart';

class QuizLandQuestionBloc extends Bloc<QuizLandQuestionEvent, QuizLandQuestionState> {
  final String id;
  final String type;
  Question? question;
  VideoTypeIsReady? videoTypeIsReady;
  PickedItem? pickedItem;
  bool? isPickedOptionCorrect;
  QuizLandQuestionBloc({QuizLandQuestionState? state, required this.id, required this.type})
      : super(state ?? QuizLandQuestionState.blank) {
    on<HeroAnimationEndEvent>((event, emit) async {
      emit(QuizLandQuestionState.localHeroMode);
      int numberOfAttempts = 20;
      do {
        await wait(milliseconds: 50);
        numberOfAttempts--;
      } while (question?.type != QuestionType.video && numberOfAttempts > 0);
      if (question?.type == QuestionType.video) {
        emit(QuizLandQuestionState.video);
      }
    });
    on<PickedOptionEvent>((event, emit) async {
      pickedItem = PickedItem(index: event.optionIndex, text: event.text, color: event.color);
      await wait(milliseconds: 500);
      emit(QuizLandQuestionState.videoPickOption);
    });
    on<ShowIsAnswerCorrectOrNotEvent>((event, emit) {
      isPickedOptionCorrect = event.isCorrect;
      emit(QuizLandQuestionState.showIsAnswerCorrectOrNot);
    });
    on<GoBackWithHeroAnimationEvent>((event, emit) {
      emit(QuizLandQuestionState.goBackWithHeroAnimation);
    });
  }

  void receiveQuestionInfoFromAssets(Question question) {
    this.question = question;
    if (this.question?.type == QuestionType.video) {
      this.question?.context.video.let((video) {
        videoTypeIsReady?.call(video);
      });
    }
  }

  void setVideoTypeListener(VideoTypeIsReady isReady) {
    videoTypeIsReady = isReady;
    if (question?.type == QuestionType.video) {
      question?.context.video.let((video) {
        videoTypeIsReady?.call(video);
      });
    }
  }
}

typedef VideoTypeIsReady = Function(QuestionVideo video);

class PickedItem extends Equatable {
  final int index;
  final String text;
  final Color color;

  const PickedItem({required this.index, required this.text, required this.color});

  @override
  List<Object?> get props => [index];
}
