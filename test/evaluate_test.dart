import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'infix_to_post_fix_test.dart';
import 'mocks/operators_builder.dart';
import 'mocks/operators_json.dart';

num evaluate(OperatorsBuilder builder, String infix) {
  List<String> postFixed = infixToPostfix(builder, infix);
  List<num> stack = [];

  for (var element in postFixed) {
    var operator = builder.itsOperator(element);
    if (operator == null) {
      stack.add(num.parse(element));
      continue;
    } else if (stack.isNotEmpty) {
      var second = stack.removeLast();
      if (operator.isBinary) {
        if (stack.isNotEmpty) {
          var first = stack.removeLast();

          if (operator.simbol == '+') {
            stack.add(first + second);
          }

          if (operator.simbol == '-') {
            stack.add(first - second);
          }

          if (operator.simbol == '*') {
            stack.add(first * second);
          }

          if (operator.simbol == '/') {
            stack.add(first / second);
          }

          if (operator.simbol == '^') {
            stack.add(pow(first, second));
          }
        }
      } else {
        if (operator.simbol == '!') {
          num factorial = 1;
          for (int index = 1; index <= second; index++) {
            factorial *= index;
          }
          stack.add(factorial);
        }
      }
    }
  }

  return stack.first;
}

void main() {
  group('Testes de valoração de expressão infixa', () {
    late OperatorsBuilder builder;

    setUp(() {
      builder = OperatorsBuilder.fromJson(json);
    });

    test('A função deve retornar 2 para "1 + 1"', () {
      var result = evaluate(builder, '1 + 1');
      expect(result, 2);
    });

    test('A função deve retornar 100 para "100 * 1"', () {
      var result = evaluate(builder, '100 * 1');
      expect(result, 100);
    });

    test('A função deve retornar 0.01 para "1 / 100"', () {
      var result = evaluate(builder, '1 / 100');
      expect(result, 0.01);
    });

    test('A função deve retornar 99 para "100 - 1"', () {
      var result = evaluate(builder, '100 - 1');
      expect(result, 99);
    });

    test('A função deve retornar -99 para "100 - 1"', () {
      var result = evaluate(builder, '1 - 100');
      expect(result, -99);
    });

    test('A função deve retornar 100 para "10 ^ 2"', () {
      var result = evaluate(builder, '10 ^ 2');
      expect(result, 100);
    });
  });
}
