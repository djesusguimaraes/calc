import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/models/operators_model.dart';
import 'package:ui_plays/providers/calc_provider.dart';

void main() {
  var builder = OperatorsBuilder.fromJson(jsonOperators);

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

      expect(provider.result, '4.2');
    });

    test(
        'Deve retornar uma string com operandos e operadores separados por espaço, e lidar com vírgulas (,)',
        () {
      var values = ['1', '.', '2', '+', '3', '3', '3', '3', '3', '3', '3'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.evaluate();

      expect(provider.result, '3333334.2');
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
      expect(provider.expression, ['1,234,567,890']);
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
      expect(provider.expression, ['123,456.890']);
    });

    test('Deve remover a última parte da expressão com pontos', () {
      var values = ['1', '2', '3', '4', '5', '6', '.', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.backSpace();
      provider.backSpace();
      provider.backSpace();

      expect(provider.expression, ['123,456']);
    });

    test('Deve limpar a expressão e o resultado', () {
      var values = ['1', '2', '3', '4', '5', '6', '.', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.evaluate();
      provider.clear();

      expect(provider.expression, isEmpty);
      expect(provider.result, isEmpty);
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
  });
}
