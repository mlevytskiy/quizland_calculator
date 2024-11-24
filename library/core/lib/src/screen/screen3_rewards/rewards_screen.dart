import 'package:core/src/app/route_aware_state.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:core/src/widget/screen_container.dart';
import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends RouteAwareState<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: "Rewards",
      child: const Text("rewards").center().container(),
    );
  }

  @override
  void onEnterScreenAfterAnimation() {}

  @override
  void onEnterScreenBeforeAnimation() {}

  @override
  void onLeaveScreen() {}
}
