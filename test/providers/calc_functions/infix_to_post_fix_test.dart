import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/models/operators_model.dart';
import 'package:ui_plays/providers/calc_functions/postfix_conversion_function.dart';

void main() {
  group('Teste de conversão Infixa para Pós-Fixa', () {
    late OperatorsBuilder builder;

    setUp(() {
      builder = OperatorsBuilder.fromJson(jsonOperators);
    });

    test('A função deve retornar um List<String>', () {
      var result = infixToPostfix(builder, '');
      expect(result, isA<List<String>>());
    });

    test('A função deve retornar um List<String> com 1 elemento', () {
      var result = infixToPostfix(builder, '1');
      expect(result.length, 1);
    });

    test('A função deve retornar "ab+c+d+e-" para "a + b + c + d - e"', () {
      var result = infixToPostfix(builder, 'a + b + c + d - e');
      expect(result, ['a', 'b', '+', 'c', '+', 'd', '+', 'e', '-']);
    });

    test('A função deve retornar "A B C + * D /" para "A * ( B + C ) / D"', () {
      var result = infixToPostfix(builder, 'A * ( B + C ) / D');
      expect(result, ['A', 'B', 'C', '+', '*', 'D', '/']);
    });

    test(
        'A função deve retornar "abcd^e-fgh*+^*+i-" para "a+b*(c^d-e)^(f+g*h)-i"',
        () {
      var result =
          infixToPostfix(builder, 'a + b * ( c ^ d - e ) ^ ( f + g * h ) - i');
      expect(result, [
        'a',
        'b',
        'c',
        'd',
        '^',
        'e',
        '-',
        'f',
        'g',
        'h',
        '*',
        '+',
        '^',
        '*',
        '+',
        'i',
        '-'
      ]);
    });
  });
}
