import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/domain/models/operators_model.dart';
import 'package:ui_plays/providers/calc_provider.dart';

void main() {
  var builder = OperatorsProvider.fromJson(jsonOperators);

  group('Teste de limpeza e avaliação da expressão evaluate\'()\':', () {
    late ExpressionChangeNotifier provider;

    setUp(() => provider = ExpressionChangeNotifier(builder));

    test(
        'Deve retornar uma string com operandos e operadores separados por espaço',
        () {
      var values = ['1', '.', '2', '+', '3'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.evaluate();

      expect(provider.result, 4.2);
    });

    test(
        'Deve retornar uma string com operandos e operadores separados por espaço, e lidar com vírgulas (,)',
        () {
      var values = ['1', '.', '2', '+', '3', '3', '3', '3', '3', '3', '3'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.evaluate();

      expect(provider.result, 3333334.2);
    });

    test('Deve retornar uma string com o resultado da expressão', () {
      var values = ['1', '.', '2', '+', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      provider.evaluate();
      expect(provider.resultString, '4.2');
    });

    test(r'''Deve retornar uma string com o
        resultado da expressão com vírgulas (,)''', () {
      var values = ['1', '.', '2', '+', '3', '3', '3', '3', '3', '3', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      provider.evaluate();
      expect(provider.resultString, '3,333,334.2');
      expect(provider.isResult, true);
    });

    test('Deve retornar o resultado da expressão com parênteses', () {
      var values = ['1', '.', '2', '+', '(', '3', '+', '3', ')'];
      for (var value in values) {
        provider.addValue(value);
      }
      provider.evaluate();
      expect(provider.result, 7.2);
    });

    test('Deve retornar o resultado da expressão memso com parênteses aberto',
        () {
      var values = ['1', '.', '2', '+', '(', '3', '+', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      provider.evaluate();
      expect(provider.result, 7.2);
    });
  });

  group('Teste de inserção de valores na expressão:', () {
    late ExpressionChangeNotifier provider;

    setUp(() => provider = ExpressionChangeNotifier(builder));

    test('Deve agrupar os números na inserção, mesmo com pontos', () {
      var values = ['1', '.', '2'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expression, ['1.2']);
    });

    test('Deve inserir o operador na expressão com espaços para os números',
        () {
      var values = ['1', '.', '2', '+', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expression, ['1.2', '+', '3']);
    });

    test('Deve substituir um operador no fim se outro operador for inserido',
        () {
      var values = ['1', '.', '2', '+', '3', '-', '+'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expression, ['1.2', '+', '3', '+']);
    });

    test('Deve inserir uma vírgula a cada casa de milhar', () {
      var values = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expressionString, '1,234,567,890');
    });

    test(
        'Deve inserir uma vírgula a cada casa de milhar e lidar com pontos (.)',
        () {
      var values = ['1', '2', '3', '.', '5', '6', '7', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expression, ['123.567890']);
    });

    test(
        'Deve inserir uma vírgula a cada casa de milhar e lidar com pontos e vírgulas (. ,)',
        () {
      var values = ['1', '2', '3', '4', '5', '6', '.', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expressionString, '123,456.890');
    });

    test('Deve remover a última parte da expressão com pontos', () {
      var values = ['1', '2', '3', '4', '5', '6', '.', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.backSpace();
      provider.backSpace();
      provider.backSpace();

      expect(provider.expressionString, '123,456');
    });

    test('Deve limpar a expressão e o resultado', () {
      var values = ['1', '2', '3', '4', '5', '6', '.', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.evaluate();
      provider.clear();

      expect(provider.expression, isEmpty);
      expect(provider.result, isNull);
    });

    test(
        'Deve retornar uma string com operandos e operadores separados por espaço',
        () {
      var values = ['1', '.', '2', '+', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expressionString, '1.2 + 3');
    });

    test(
        'Deve retornar uma string com operandos e operadores separados por espaço, e lidar com vírgulas (,)',
        () {
      var values = ['1', '.', '2', '+', '3', '3', '3', '3', '3', '3', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expressionString, '1.2 + 3,333,333');
    });

    test('Deve inserir um parêntese aberto para a expressão vazia', () {
      provider.addParenthesis();
      expect(provider.expression, ['(']);
    });

    test(
        'Deve inserir um parêntese fechado ")" para a expressão "1.2 + ( 3 - 1"',
        () {
      var values = ['1', '.', '2', '+', '(', '3', '-', '1'];
      for (var value in values) {
        provider.addValue(value);
      }
      provider.addParenthesis();
      expect(provider.realExpression.endsWith(')'), true);
    });
  });

  group('Testes de mudança de sinal:', () {
    late ExpressionChangeNotifier provider;

    setUp(() => provider = ExpressionChangeNotifier(builder));

    test('Deve mudar o sinal de um número positivo para negativo', () {
      var values = ['1', '.', '2', '+', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      provider.changeSign(7);
      expect(provider.expression, ['1.2', '+', '(', '-', '3']);
    });

    test('Deve mudar o sinal de um número negativo para positivo', () {
      var values = ['1', '.', '2', '+', '(', '-', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      provider.changeSign(8);
      expect(provider.expression, ['1.2', '+', '3']);
    });
  });
}
