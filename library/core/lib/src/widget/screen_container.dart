import 'dart:ui';

import 'package:conditional_wrap/conditional_wrap.dart';
import 'package:flutter/material.dart';

import '../app/utils.dart';

class ScreenContainer extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool hideUpArrow;

  const ScreenContainer({
    super.key,
    required this.child,
    this.title,
    this.hideUpArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: title != null,
      appBar: title?.let(
        (it) => AppBar(
          leading: title != null && !hideUpArrow
              ? IconButton(
                  icon: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                      child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x44000000),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: !hideUpArrow,
          title: Text(it),
        ),
      ),
      body: WidgetWrapper(
          wrapper: (Widget child) {
            if (title == null) {
              return SafeArea(child: child);
            } else {
              return child;
            }
          },
          child: child),
    );
  }
}
