import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_formatter/money_formatter.dart';

import '../evaluate_test.dart';
import '../mocks/operators_builder.dart';
import '../mocks/operators_json.dart';

class ExpressionChangeNotifier extends ChangeNotifier {
  List<String> expression = [];
  String result = '';

  OperatorsBuilder builder = OperatorsBuilder.fromJson(json);

  String get expressionString => expression.join('');

  void clear() => expression.clear();

  void evaluate() {
    var treatedExpression = expression.join(' ').replaceAll(',', '');
    result = moneyFormat(evaluateExpression(builder, treatedExpression).toString(), withDecimal: true);
    notifyListeners();
  }

  void addValue(String value) {
    var realExpression = expression.isNotEmpty ? expression.last.replaceAll(',', '') : '';
    bool isLastValueANumber = expression.isNotEmpty ? num.tryParse(realExpression) != null : false;
    bool isLastADot = expression.isNotEmpty ? realExpression.split('').last == '.' : false;

    if (value == '.' && isLastADot) return;

    bool isValueANumber = num.tryParse(value) != null;

    bool numberAndNumber = isValueANumber && isLastValueANumber;
    bool numberAndDot = isLastValueANumber && value == '.';
    bool dotAndNumber = isLastADot && isValueANumber;

    bool shouldConcatenate = numberAndNumber || dotAndNumber || numberAndDot;
    if (shouldConcatenate) {
      if (expression.isEmpty) {
        expression.add(value);
        notifyListeners();
        return;
      }

      if (!expression.last.contains('.') && isValueANumber) {
        if (expression.last.length >= 3) {
          var newValue = expression.removeLast().replaceAll(',', '') + value;
          expression.add(moneyFormat(newValue));
          notifyListeners();
          return;
        }
      }

      var last = expression.removeLast();
      expression.add(last + value);
      notifyListeners();
      return;
    }

    bool isValueAnOperator = builder.itsOperator(value) != null;
    bool isLastValueAnOperator = expression.isNotEmpty ? builder.itsOperator(realExpression) != null : false;
    if (isValueAnOperator && isLastValueAnOperator) {
      expression.removeLast();
      expression.add(value);
      notifyListeners();
      return;
    }

    expression.add(value);
    notifyListeners();
  }
}

moneyFormat(String value, {bool withDecimal = false}) {
  var fo = MoneyFormatter(amount: double.parse(value)).output;
  return withDecimal ? fo.nonSymbol : fo.withoutFractionDigits;
}

void main() {
  group('Teste de limpeza e avaliação da expressão evaluate\'()\'', () {
    late ExpressionChangeNotifier provider;

    setUp(() => provider = ExpressionChangeNotifier());

    test('Deve retornar uma string com operandos e operadores separados por espaço', () {
      var values = ['1', '.', '2', '+', '3'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.evaluate();

      expect(provider.result, '4.20');
    });

    test('Deve retornar uma string com operandos e operadores separados por espaço, e lidar com vírgulas (,)', () {
      var values = ['1', '.', '2', '+', '3', '3', '3', '3', '3', '3', '3'];
      for (var value in values) {
        provider.addValue(value);
      }

      provider.evaluate();

      expect(provider.result, '3,333,334.20');
    });
  });

  group('Teste de inserção de valores na expressão', () {
    late ExpressionChangeNotifier provider;

    setUp(() => provider = ExpressionChangeNotifier());

    test('Deve agrupar os números na inserção, mesmo com pontos', () {
      var values = ['1', '.', '2'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expression, ['1.2']);
    });

    test('Deve inserir o operador na expressão com espaços para os números', () {
      var values = ['1', '.', '2', '+', '3'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expression, ['1.2', '+', '3']);
    });

    test('Deve substituir um operador no fim se outro operador for inserido', () {
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

    test('Deve inserir uma vírgula a cada casa de milhar e lidar com pontos (.)', () {
      var values = ['1', '2', '3', '.', '5', '6', '7', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expression, ['123.567890']);
    });

    test('Deve inserir uma vírgula a cada casa de milhar e lidar com pontos (.)', () {
      var values = ['1', '2', '3', '4', '5', '6', '.', '8', '9', '0'];
      for (var value in values) {
        provider.addValue(value);
      }
      expect(provider.expression, ['123,456.890']);
    });
  });
}
