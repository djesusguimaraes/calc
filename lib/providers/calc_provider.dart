import 'package:flutter/material.dart';
import 'package:ui_plays/utils/money_formatter_util.dart';

import '../models/operators_model.dart';
import 'calc_functions/evaluate_expression_function.dart';

class ExpressionChangeNotifier extends ChangeNotifier {
  List<String> expression = [];
  String result = '';

  OperatorsBuilder builder;

  ExpressionChangeNotifier(this.builder);

  String get expressionString => expression.join(' ');

  void clear() {
    expression.clear();
    result = '';
    notifyListeners();
  }

  void backSpace() {
    if (expression.isNotEmpty) {
      expression.removeLast();
      notifyListeners();
    }
  }

  void changeSign() {}

  void addParenthesis() {}

  void evaluate() {
    var treatedExpression = expression.join(' ').replaceAll(',', '');
    result = evaluateExpression(builder, treatedExpression).toString();
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
