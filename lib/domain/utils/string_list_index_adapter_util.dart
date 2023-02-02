import 'package:ui_plays/domain/extensions/range_extension.dart';

mixin StringListIndexAdapterUtil {
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

  int foundItemIndexByCursorPos({
    required int offset,
    required String expressionString,
    required List<String> expression,
  }) {
    int cursorPos = offset > 0 ? offset - 1 : offset;

    String preffix = expressionString.substring(0, cursorPos);
    int countSpaces =
        preffix.isNotEmpty ? RegExp(r' ').allMatches(preffix).length : 0;

    int queryIndex = countSpaces > 0 ? cursorPos - countSpaces : cursorPos;

    List<Set<int>> interface = _buildIndexInterface(expression);

    return interface
        .indexWhere((path) => queryIndex.isBetween(path.first, path.last));
  }
}
