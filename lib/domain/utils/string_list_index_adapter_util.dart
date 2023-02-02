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
    if (offset > expressionString.length) return -1;

    int selection = offset > 0 ? offset - 1 : offset;

    String preffix = expressionString.substring(0, offset);
    int countSpaces =
        preffix.isNotEmpty ? RegExp(r' ').allMatches(preffix).length : 0;

    int queryIndex = countSpaces > 0 ? selection - countSpaces : selection;

    int index = _buildIndexInterface(expression)
        .indexWhere((path) => queryIndex.isBetween(path.first, path.last));

    if (index <= 0 || num.tryParse(expression[index]) != null) return index;

    int preffixUntilNumber = 0;
    for (var char in preffix.split('').reversed) {
      if (num.tryParse(char) != null) break;
      preffixUntilNumber++;
    }

    if (preffixUntilNumber == 0) return index - 1;

    String suffix = expressionString.substring(offset);

    int suffixUntilNumber = 0;
    for (var char in suffix.split('')) {
      if (num.tryParse(char) != null) break;
      suffixUntilNumber++;
    }

    return index + (preffixUntilNumber >= suffixUntilNumber ? 1 : -1);
  }
}
