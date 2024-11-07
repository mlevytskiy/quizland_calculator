import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/utils.dart';

class ScreenContainer extends StatelessWidget {
  final Widget child;
  final String? title;

  const ScreenContainer({
    super.key,
    required this.child,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title?.let(
        (it) => CupertinoNavigationBar(
          middle: Text(it),
        ),
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}
