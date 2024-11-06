import 'impl/button_background.dart';

enum HarryPotterButtonState {
  showOnly934(buttonBackgroundViewTypeEnum: ButtonBackgroundViewTypeEnum.point),
  circleButton(
    lightningWidth: 60.0,
    lightningHeight: 60.0,
    eyesGlassesWidth: 100.0,
    eyesGlassesHeight: 70.0,
  ),
  rectangleHeader(
    buttonBackgroundViewTypeEnum: ButtonBackgroundViewTypeEnum.rectangle,
    hideImagesLightingAndEyesGlasses: true,
    showYellowCircle: true,
  ),
  rectangleHeaderWithText(
    buttonBackgroundViewTypeEnum: ButtonBackgroundViewTypeEnum.rectangle,
    hideImagesLightingAndEyesGlasses: true,
    showYellowCircle: true,
    showHeaderTextMessage: true,
  ),
  rectangleHeaderWithRightText(
    buttonBackgroundViewTypeEnum: ButtonBackgroundViewTypeEnum.rectangle,
    hideImagesLightingAndEyesGlasses: true,
    showYellowCircle: true,
    showHeaderTextMessage: true,
    showExam: true,
  );

  final double lightningWidth;
  final double lightningHeight;
  final double eyesGlassesWidth;
  final double eyesGlassesHeight;
  final ButtonBackgroundViewTypeEnum buttonBackgroundViewTypeEnum;
  final bool hideImagesLightingAndEyesGlasses;
  final bool showYellowCircle;
  final bool showHeaderTextMessage;
  final bool showExam;

  const HarryPotterButtonState({
    this.lightningWidth = 0.0,
    this.lightningHeight = 0.0,
    this.eyesGlassesWidth = 0.0,
    this.eyesGlassesHeight = 0.0,
    this.buttonBackgroundViewTypeEnum = ButtonBackgroundViewTypeEnum.circle,
    this.hideImagesLightingAndEyesGlasses = false,
    this.showYellowCircle = false,
    this.showHeaderTextMessage = false,
    this.showExam = false,
  });
}
