import 'package:flutter_test/flutter_test.dart';

import 'mocks/operator_model.dart';
import 'mocks/operators_builder.dart';
import 'mocks/operators_json.dart';

List<String> infixToPostfix(OperatorsBuilder builder, String infix) {
  List<String> result = [];
  List<Operator> stack = [];

  List<String> infixList = infix.split(' ');
  for (var element in infixList) {
    if (element == '(') {
      stack.add(builder.open);
      continue;
    }

    if (element == ')') {
      var reversed = stack.reversed.toList();
      for (var element in reversed) {
        stack.removeLast();
        if (element == builder.open) {
          break;
        } else {
          result.add(element.simbol);
        }
      }
      continue;
    }

    var operator = builder.itsOperator(element);
    if (operator == null) {
      result.add(element);
      continue;
    } else {
      if (stack.isNotEmpty) {
        var reversed = stack.reversed.toList();
        for (var stacked in reversed) {
          if (stacked.precedence >= operator.precedence) {
            result.add(stacked.simbol);
            stack.removeLast();
          } else {
            break;
          }
        }
      }
      stack.add(operator);
      continue;
    }
  }

  if (stack.isNotEmpty) {
    var reversed = stack.reversed.toList();
    for (var element in reversed) {
      result.add(element.simbol);
      stack.removeLast();
    }
  }

  return result;
}

void main() {
  group('Teste de conversão Infixa para Pós-Fixa', () {
    late OperatorsBuilder builder;

    setUp(() {
      builder = OperatorsBuilder.fromJson(json);
    });

    test('A função deve retornar um List<String>', () {
      var result = infixToPostfix(builder, '');
      expect(result, isA<List<String>>());
    });

    test('A função deve retornar um List<String> com 1 elemento', () {
      var result = infixToPostfix(builder, '1');
      expect(result.length, 1);
    });

    test('A função deve retornar "A B C + * D /" para "A * ( B + C ) / D"', () {
      var result = infixToPostfix(builder, 'a + b + c + d - e');
      expect(result, ['a', 'b', '+', 'c', '+', 'd', '+', 'e', '-']);
    });

    test('A função deve retornar "A B C + * D /" para "A * ( B + C ) / D"', () {
      var result = infixToPostfix(builder, 'A * ( B + C ) / D');
      expect(result, ['A', 'B', 'C', '+', '*', 'D', '/']);
    });

    test('A função deve retornar "abcd^e-fgh*+^*+i-" para "a+b*(c^d-e)^(f+g*h)-i"', () {
      var result = infixToPostfix(builder, 'a + b * ( c ^ d - e ) ^ ( f + g * h ) - i');
      expect(result, ['a', 'b', 'c', 'd', '^', 'e', '-', 'f', 'g', 'h', '*', '+', '^', '*', '+', 'i', '-']);
    });
  });
}
