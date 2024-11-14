import 'dart:math';

/**
 * Help generate coordinates for constraint layout
 */
class CoordinateBuilder {
  static const matrixFor5Elements = '''
                        . . . . . . . .
                        . . . . . . . 0
                        . 1 . . . . . .
                        . . . . . . . .
                        . . . . . 2 . .
                        . . . . . . . .
                        . . 3 . . . . .
                        . . . . . . 4 .
  ''';

  List<List<String>> _array = [];
  late int _arrayXLength;
  late int _arrayYLength;

  List<Point<double>> _coordinates = [];

  /*
    example of 2DArray in String:
    . . 1
    2 2 2
    3 3 3

    where . - no item,
    1 - some item with type 1
   */
  void _set2DArrayStr(String str2DArray) {
    _array = _get2DArray(str2DArray);
    _arrayYLength = _array.length;
    _arrayXLength = _array[0].length;
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

  void setItemAmount(int amount) {
    // if (amount == 5) {
    _set2DArrayStr(matrixFor5Elements);
    // }
    _coordinates = _getIndexes(amount).map((point) => _convertIndexesToCoordinate(point)).toList();
  }

  Point<double> get(int index) {
    return _coordinates[index];
  }

  List<Point<int>> _getIndexes(int amountOfElements) {
    Map<String, Point<int>> map = {};
    for (int i = 0; i < _array.length; i++) {
      for (int j = 0; j < _array[i].length; j++) {
        String item = _array[i][j];
        if (item != ".") {
          print("item=${item}");
          map[item] = Point(j, i);
        }
      }
    }
    List<Point<int>> result = [];
    for (int i = 0; i < amountOfElements; i++) {
      result.add(map[i.toString()]!);
    }
    return result;
  }

  Point<double> _convertIndexesToCoordinate(Point<int> value) {
    return Point(value.x / _arrayXLength, value.y / _arrayYLength);
  }
}
