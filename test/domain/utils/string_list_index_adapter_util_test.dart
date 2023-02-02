import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/domain/utils/string_list_index_adapter_util.dart';

var expression = ['1234', '+', '236'];

var expressionString = '1234 + 236';

class StringListAdapterTest with StringListIndexAdapterUtil {}

void main() {
  group('Teste StringListIndexAdapterUtil:', () {
    late StringListAdapterTest stringListAdapter;
    setUp(() => stringListAdapter = StringListAdapterTest());

    test('Deve indentificar um elemento no array baseada em uma string', () {
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 0,
              expressionString: expressionString,
              expression: expression),
          0);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 1,
              expressionString: expressionString,
              expression: expression),
          0);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 2,
              expressionString: expressionString,
              expression: expression),
          0);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 3,
              expressionString: expressionString,
              expression: expression),
          0);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 4,
              expressionString: expressionString,
              expression: expression),
          0);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 5,
              expressionString: expressionString,
              expression: expression),
          1);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 6,
              expressionString: expressionString,
              expression: expression),
          1);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 7,
              expressionString: expressionString,
              expression: expression),
          2);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 8,
              expressionString: expressionString,
              expression: expression),
          2);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 9,
              expressionString: expressionString,
              expression: expression),
          2);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 10,
              expressionString: expressionString,
              expression: expression),
          2);
      expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: 11,
              expressionString: expressionString,
              expression: expression),
          -1);
    });
  });
}
