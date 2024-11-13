import 'package:core/src/app/bloc/semaphore.dart';
import 'package:core/src/app/bloc/side_effect_bloc.dart';
import 'package:core/src/app/data/question.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/quiz_land_question_event.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/quiz_land_question_side_effect.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/quiz_land_question_state.dart';

class QuizLandQuestionBloc
    extends SideEffectBloc<QuizLandQuestionEvent, QuizLandQuestionState, QuizLandQuestionSideEffect> {
  final Semaphore _semaphore = Semaphore<QuizLandQuestionState, Question>((emit, data) {
    QuizLandQuestionState state = switch (data?.type) {
      QuestionType.video => VideoQuizLandQuestionState(video: data!.context.video!),
      QuestionType.simple4Options => Simple4OptionsQuizLandQuestionState(simple4Options: data!.context.simple4options!),
      _ => Simple4OptionsQuizLandQuestionState(
          simple4Options: const Simple4Options("", "", [], Simple4OptionSubtype.textInOptions)),
    };
    emit(state);
  });

  QuizLandQuestionBloc({QuizLandQuestionState? state})
      : super(state ?? BlankQuizLandQuestionState(BlankTypeEnum.general)) {
    _semaphore.acquire(); //wait end of hero animation;
    _semaphore.acquire(); //wait end of assets loading;
    on<HeroAnimationEndEvent>((event, emit) => _semaphore.release(emit));
    on<LoadingAssetsFinishedEvent>((event, emit) => _semaphore.release(emit,
        data: event.question, sideEffectCallback: () => emitSideEffect(EnableLocalHeroModeSideEffect())));
  }
}
