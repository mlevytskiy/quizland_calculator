import 'package:core/src/app/data/question.dart';

extension QuestionExtension on Question {
  List<String?> getImagePathsForPrecache() {
    if (type == QuestionType.simple4Options) {
      List<String?> optionImages = context.simple4options?.options.map((item) => item.imageFile).toList() ?? [];
      return [context.simple4options?.imageFile, ...optionImages];
    } else if (type == QuestionType.pickMultiplePersonages) {
      List<String?> optionImages = context.pickMultiplePersonages?.options.map((item) => item.avatar).toList() ?? [];
      return [context.pickMultiplePersonages?.imageFile, ...optionImages];
    }
    return [];
  }
}
