import 'package:conditional_wrap/conditional_wrap.dart';
import 'package:flutter/material.dart';

import '../app/utils.dart';

class GridViewBuilder {
  List<List<String>> _array = [];
  Map<String, Widget> widgetMap = <String, Widget>{".": Container(color: Colors.transparent)};
  ItemClickListener? _itemClickListener;
  Map<String, bool?>? _quizResult;

  /*
    example of 2DArray in String:
    . . 1
    2 2 2
    3 3 3

    where . - no item,
    1 - some item with type 1
   */
  void set2DArrayStr(String str2DArray) {
    _array = _get2DArray(str2DArray);
  }

  void setItemClickListener(ItemClickListener value) {
    _itemClickListener = value;
  }

  void setQuizResult(Map<String, bool?> value) {
    _quizResult = value;
  }

  List<List<String>> _get2DArray(String str2DArray) {
    List<String> rows = str2DArray.split('\n');
    List<List<String>> result = [];
    for (int i = 0; i < rows.length; i++) {
      rows[i] = rows[i].trim();
      if (rows[i].isEmpty) {
        rows.removeAt(i);
        i--;
        continue;
      }
      List<String> items = rows[i].split(' ');
      for (int j = 0; j < items.length; j++) {
        items[j] = items[j].trim();
        if (items[j].isEmpty) {
          items.removeAt(j);
          j--;
          continue;
        }
      }
      result.add(items);
    }
    return result;
  }

  void addWidget(String name, Widget widget) {
    widgetMap[name] = widget;
  }

  GridViewParam build() {
    List<Widget> widgets = [];
    for (int i = 0; i < _array.length; i++) {
      for (int j = 0; j < _array[i].length; j++) {
        String item = _array[i][j];
        String? itemId = _getItemId(item);
        String type = _getItemType(item);
        Widget itemWidget = widgetMap[type]!;
        itemWidget = itemId?.let((id) => _itemClickListener?.let((listener) =>
                ItemClickWrapper(_quizResult, id: id, type: type, listener: listener, child: itemWidget))) ??
            itemWidget;
        widgets.add(itemWidget);
      }
    }
    int columnCount = _array[0].length;
    int rowCount = _array.length;
    return GridViewParam(_itemClickListener, rowCount: rowCount, columnCount: columnCount, widgets: widgets);
  }

  String _getItemType(String itemIn2DArray) {
    return itemIn2DArray[0];
  }

  String? _getItemId(String itemIn2DArray) {
    if (itemIn2DArray == '..') {
      return null;
    }
    return itemIn2DArray.substring(1);
  }
}

class GridViewParam {
  final int rowCount;
  final int columnCount;
  final ItemClickListener? itemClickListener;
  final List<Widget> widgets;
  GridViewParam(this.itemClickListener, {required this.rowCount, required this.columnCount, required this.widgets});
}

typedef ItemClickListener = void Function(String id, String type);

class ItemClickWrapper extends StatelessWidget {
  final String id;
  final String type;
  final ItemClickListener? listener;
  final Widget child;
  final Map<String, bool?>? _quizResult;
  const ItemClickWrapper(this._quizResult,
      {super.key, required this.id, this.listener, required this.child, required this.type});

  @override
  Widget build(BuildContext context) {
    bool? result = _quizResult?.let((it) => it[id]);
    return WidgetWrapper(
      wrapper: (Widget child) {
        if (result == null) {
          return child;
        } else if (result) {
          return Stack(
            children: [
              child,
              Positioned.fill(child: Container(color: Colors.black.withAlpha(125))),
              const Positioned.fill(child: Center(child: Icon(Icons.check, color: Colors.white))),
            ],
          );
        } else {
          return Stack(
            children: [
              child,
              Positioned.fill(child: Container(color: Colors.black.withAlpha(125))),
              const Positioned.fill(child: Center(child: Icon(Icons.close, color: Colors.white))),
            ],
          );
        }
      },
      child: GestureDetector(
          onTap: () {
            listener?.call(id, type);
          },
          child: Hero(tag: id, child: child)),
    );
  }
}
