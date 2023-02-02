import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/domain/utils/string_list_index_adapter_util.dart';

var expression = ['1234', '+', '236'];

var expressionString = '1234 + 236';

class StringListAdapterTest with StringListIndexAdapterUtil {}

void main() {
  group('Teste StringListIndexAdapterUtil:', () {
    late StringListAdapterTest stringListAdapter;
    setUp(() => stringListAdapter = StringListAdapterTest());

    test(
        'Deve indentificar o elemento "0" no array baseada nos offsets no intervalo [0-4]',
        () {
      for (var i = 0; i < 5; i++) {
        expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: i,
              expressionString: expressionString,
              expression: expression),
          0,
        );
      }
    });

    test(
        'Deve indentificar o elemento "2" no array baseada nos offsets no intervalo [7-10]',
        () {
      for (var i = 7; i < 11; i++) {
        expect(
          stringListAdapter.foundItemIndexByCursorPos(
              offset: i,
              expressionString: expressionString,
              expression: expression),
          2,
        );
      }
    });

    test(
        'Deve retornar -1 se o offset estiver fora do intervalo de caracteres da expressão',
        () {
      expect(
        stringListAdapter.foundItemIndexByCursorPos(
            offset: 11,
            expressionString: expressionString,
            expression: expression),
        -1,
      );
    });

    test(
        'Deve retornar o index do número mais próximo se não encontrar um número',
        () {
      var expects = [0, 2, 2];
      for (var i = 5, j = 0; i < 8; i++, j++) {
        expect(
          stringListAdapter.foundItemIndexByCursorPos(
            offset: i,
            expressionString: expressionString,
            expression: expression,
          ),
          expects.elementAt(j),
        );
      }
    });
  });
}
