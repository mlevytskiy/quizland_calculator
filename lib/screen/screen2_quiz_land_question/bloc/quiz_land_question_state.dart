enum QuizLandQuestionState {
  blank(heroState: HeroState.heroEnable, headerBackgroundOpacity: 0.8),
  localHeroMode(headerBackgroundOpacity: 0.8),
  video(showVideoPlayer: true),
  videoPickOption(showVideoPlayer: true),
  resumeVideo(showVideoPlayer: true),
  showIsAnswerCorrectOrNot(showVideoPlayer: true),
  goBackWithHeroAnimation(showVideoPlayer: true, heroState: HeroState.heroEnable);

  final HeroState heroState;
  final double headerBackgroundOpacity;
  final bool showVideoPlayer;

  const QuizLandQuestionState(
      {this.heroState = HeroState.localHeroEnable, this.headerBackgroundOpacity = 0.3, this.showVideoPlayer = false});
}

enum HeroState {
  heroEnable(true, false),
  localHeroEnable(false, true);

  final bool isHeroEnable;
  final bool isLocalHeroEnable;

  const HeroState(this.isHeroEnable, this.isLocalHeroEnable);
}
