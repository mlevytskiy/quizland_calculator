enum HeroState {
  localHero(isLocalHeroEnable: true, isHeroEnable: false),
  betweenScreens(isLocalHeroEnable: false, isHeroEnable: true);

  final bool isLocalHeroEnable;
  final bool isHeroEnable;

  const HeroState({required this.isLocalHeroEnable, required this.isHeroEnable});
}
