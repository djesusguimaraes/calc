import 'package:flutter/material.dart';
import 'package:ui_plays/domain/models/expression_status_model.dart';
import 'package:ui_plays/domain/utils/string_list_index_adapter_util.dart';
import 'package:ui_plays/providers/calc_functions/postfix_conversion_function.dart';
import 'package:ui_plays/domain/utils/mark_thousand_util.dart';

import '../domain/models/operators_model.dart';
import 'calc_functions/evaluate_expression_function.dart';

class ExpressionChangeNotifier extends ChangeNotifier
    with StringListIndexAdapterUtil {
  List<String> expression = [];
  num? result;
  num _partialResult = 0;

  ExpressionStatus status = ExpressionStatus();

  OperatorsProvider builder;

  ExpressionChangeNotifier(this.builder);

  String get expressionString {
    if (expression.isEmpty) return '';

    List<String> out = [];
    for (var operand in expression) {
      out.add(num.tryParse(operand) != null ? markThousand(operand) : operand);
    }

    return out.join(' ');
  }

  String get resultString =>
      markThousand((!isResult ? _partialResult : result).toString());

  bool get isResult => result != null;

  void clear() {
    result = null;
    expression.clear();
    notifyListeners();
  }

  void backSpace() {
    if (expression.isNotEmpty) {
      var last = expression.removeLast();
      if (num.tryParse(last) != null) {
        if (last.length > 1) {
          var backspace = last.length - 1;

          if (last[last.length - 2] == '.') backspace--;

          expression.add(last.substring(0, backspace));
        }
      }
      _evaluatePartial();
      notifyListeners();
    }
  }

  void changeSign(int offset) {
    var index = foundItemIndexByCursorPos(
        offset: offset,
        expressionString: expressionString,
        expression: expression);

    if (index < 0) return;
  }

  void addParenthesis() {
    _addValue(status.thereIsOpenParenthesis ? ')' : '(');
    _updateStatus();
  }

  void evaluate() {
    if (!status.thereIsOpenParenthesis) {
      var treatedExpression = expression.join(' ');
      result = evaluateExpression(builder, treatedExpression);
      notifyListeners();
    }
  }

  void addValue(String value) {
    _addValue(value);
    _updateStatus();
    _evaluatePartial();
  }

  void _addValue(String value) {
    var realExpression = expression.isNotEmpty ? expression.last : '';
    bool isLastValueANumber =
        expression.isNotEmpty ? num.tryParse(realExpression) != null : false;
    bool isLastADot =
        expression.isNotEmpty ? realExpression.split('').last == '.' : false;

    if (value == '.' && isLastADot) return;

    bool isValueANumber = num.tryParse(value) != null;

    bool numberAndNumber = isValueANumber && isLastValueANumber;
    bool numberAndDot = isLastValueANumber && value == '.';
    bool dotAndNumber = isLastADot && isValueANumber;

    bool shouldConcatenate = numberAndNumber || dotAndNumber || numberAndDot;
    if (shouldConcatenate) {
      if (!expression.last.contains('.') && isValueANumber) {
        if (expression.last.length >= 3) {
          var newValue = expression.removeLast() + value;
          expression.add(newValue);
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
    bool isLastValueAnOperator = expression.isNotEmpty
        ? builder.itsOperator(realExpression) != null
        : false;
    if (isValueAnOperator && isLastValueAnOperator) {
      expression.removeLast();
      expression.add(value);
      notifyListeners();
      return;
    }

    expression.add(value);
    notifyListeners();
  }

  void _evaluatePartial() {
    if (expression.isNotEmpty && !status.thereIsOpenParenthesis) {
      if (num.tryParse(expression.last) != null) {
        _partialResult = evaluateExpression(builder, expression.join(' '));
      } else {
        _partialResult = 0;
      }
      notifyListeners();
    }
  }

  void _updateStatus() {
    if (expression.isNotEmpty) {
      status = infixToPostfix(builder, expression.join(' '));
    }
  }
}
