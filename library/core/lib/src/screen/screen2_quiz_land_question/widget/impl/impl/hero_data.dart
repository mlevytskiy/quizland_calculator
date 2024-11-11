class HeroData {
  final HeroMode mode;
  final String heroTag;
  final String localHeroTag;
  final String heroTag2ForText;

  HeroData({required this.mode, required this.heroTag, required this.localHeroTag, required this.heroTag2ForText});

  factory HeroData.create(bool isLocalHeroEnable, {required String tag, required String heroTag2ForText}) {
    return HeroData(
        mode: isLocalHeroEnable ? HeroMode.localHero : HeroMode.hero,
        heroTag: tag,
        localHeroTag: tag,
        heroTag2ForText: heroTag2ForText);
  }
}

enum HeroMode {
  localHero(true, false),
  hero(false, true),
  none(false, false);

  final bool isLocalHeroEnable;
  final bool isHeroEnable;

  const HeroMode(this.isLocalHeroEnable, this.isHeroEnable);
}
