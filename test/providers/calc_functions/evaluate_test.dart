import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/domain/models/operators_model.dart';
import 'package:ui_plays/providers/calc_functions/evaluate_expression_function.dart';
import 'package:ui_plays/providers/calc_functions/postfix_conversion_function.dart';

void main() {
  group('Testes de valoração de expressão infixa:', () {
    late OperatorsProvider builder;

    setUp(() {
      builder = OperatorsProvider.fromJson(jsonOperators);
    });

    getPostfixed(String value) =>
        infixToPostfix(builder, value).postfixExpression;

    test('A função deve retornar 2 para "1 + 1"', () {
      var result = evaluateExpression(builder, getPostfixed('1 + 1'));
      expect(result, 2);
    });

    test('A função deve retornar 100 para "100 * 1"', () {
      var result = evaluateExpression(builder, getPostfixed('100 * 1'));
      expect(result, 100);
    });

    test('A função deve retornar 0.01 para "1 / 100"', () {
      var result = evaluateExpression(builder, getPostfixed('1 / 100'));
      expect(result, 0.01);
    });

    test('A função deve retornar 99 para "100 - 1"', () {
      var result = evaluateExpression(builder, getPostfixed('100 - 1'));
      expect(result, 99);
    });

    test('A função deve retornar -99 para "100 - 1"', () {
      var result = evaluateExpression(builder, getPostfixed('1 - 100'));
      expect(result, -99);
    });

    test('A função deve retornar 100 para "10 ^ 2"', () {
      var result = evaluateExpression(builder, getPostfixed('10 ^ 2'));
      expect(result, 100);
    });

    test('A função deve retornar 500 para "100.000 / 2"', () {
      var result = evaluateExpression(builder, getPostfixed('100000 / 2'));
      expect(result, 50000);
    });

    test('Deve retornar a centésima parte do número passado', () {
      var result = evaluateExpression(builder, getPostfixed('1 %'));
      expect(result, 0.01);
    });

    test('Deve retornar o fatorial do número passado', () {
      var result = evaluateExpression(builder, getPostfixed('3 !'));
      expect(result, 6);
    });
  });
}
