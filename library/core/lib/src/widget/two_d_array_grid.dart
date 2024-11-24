import 'package:flutter/material.dart';

class TwoDArrayGrid extends GridView {
  final String str2DArray;
  final Map<String, Widget> widgetMap;

  TwoDArrayGrid({
    super.key,
    required this.str2DArray,
    required this.widgetMap,
    required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    super.cacheExtent,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    List<Widget>? children,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.clipBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
  }) : super(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          semanticChildCount: semanticChildCount ?? children?.length ?? 0,
          children: children ?? _convert2DArrayToWidgets(str2DArray) ?? const <Widget>[],
        );

  static List<Widget>? _convert2DArrayToWidgets(String str2DArr) {
    return <Widget>[
      Container(width: 40, height: 40, color: Colors.red),
      Container(width: 40, height: 40, color: Colors.blue),
      Container(width: 40, height: 40, color: Colors.yellow),
      Container(width: 40, height: 40, color: Colors.red),
      Container(width: 40, height: 40, color: Colors.blue),
      Container(width: 40, height: 40, color: Colors.yellow),
      Container(width: 40, height: 40, color: Colors.red),
      Container(width: 40, height: 40, color: Colors.blue),
      Container(width: 40, height: 40, color: Colors.yellow),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
