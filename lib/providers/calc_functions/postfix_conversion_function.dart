import 'package:ui_plays/domain/models/expression_status_model.dart';

import '../../domain/models/operators_model.dart';

ExpressionStatus infixToPostfix(OperatorsProvider builder, String infix) {
  List<String> result = [];
  List<Operator> stack = [];

  int openParenthesisCount = 0;

  List<String> infixList = infix.split(' ');
  for (var element in infixList) {
    if (element == '(') {
      openParenthesisCount++;
      stack.add(builder.open);
      continue;
    }

    if (element == ')') {
      openParenthesisCount--;
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

  return ExpressionStatus(
    openParenthesisCount: openParenthesisCount,
    postfixExpression: result,
  );
}
