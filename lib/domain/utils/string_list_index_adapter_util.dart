import 'package:ui_plays/domain/extensions/range_extension.dart';

mixin StringListIndexAdapterUtil {
  /// Returns the index of an operand in the list that is closest to the cursor
  int foundItemIndexByCursorPos({
    required int offset,
    required String expressionString,
    required List<String> expression,
  }) {
    if (offset > expressionString.length) return -1;

    int selection = offset > 0 ? offset - 1 : offset;

    String preffix = expressionString.substring(0, offset);
    int countSpaces =
        preffix.isNotEmpty ? RegExp(r' ').allMatches(preffix).length : 0;

    int queryIndex = countSpaces > 0 ? selection - countSpaces : selection;

    int index = _buildIndexInterface(expression).indexWhere(
      (path) => queryIndex.isBetween(path.first, path.last),
    );

    if (index <= 0 || num.tryParse(expression[index]) != null) return index;

    return _moveToClosestNumber(
        preffix, expressionString.substring(offset), index);
  }

  /// Returns an array that represents the indexes limit of each item in the list
  /// based on the string indexes of the expression
  ///
  /// * Example:
  ///   * `expression`: `['123', '+', '258', '*', '3']`
  ///   * `interface`: `[{0, 2}, {3}, {4, 6}, {7}, {8}]`
  List<Set<int>> _buildIndexInterface(List<String> expression) {
    var interface = <Set<int>>[];
    int likeStringIndex = 0;
    for (var element in expression) {
      var indexes = {likeStringIndex};
      if (element.length > 1) {
        likeStringIndex += element.length - 1;
        indexes.add(likeStringIndex);
      }
      interface.add(indexes);
      likeStringIndex++;
    }
    return interface;
  }

  _moveToClosestNumber(
    String preffix,
    String suffix,
    int index,
  ) {
    int prefCount = _charsUntilNumber(preffix, reverse: true);

    if (prefCount == 1) return index - 1;

    int suffCount = _charsUntilNumber(suffix);

    if (suffCount == 1) return index + 1;

    return index + (prefCount >= suffCount ? suffCount : -prefCount);
  }

  _charsUntilNumber(String value, {bool reverse = false}) {
    int count = 1;
    List<String> iterable = value.trim().split(' ');
    if (reverse) iterable = iterable.reversed.toList();
    for (var char in iterable) {
      if (num.tryParse(char) != null) break;
      count++;
    }
    return count;
  }
}
