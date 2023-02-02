import 'package:ui_plays/domain/enums/operand_type_enum.dart';
import 'package:ui_plays/domain/models/expression_status_model.dart';

import '../../domain/models/operators_model.dart';

ExpressionStatus infixToPostfix(OperatorsProvider builder, String infix) {
  List<String> result = [];
  List<Operator> stack = [];

  bool hasOpenParenthesis = false;

  List<String> infixList = infix.split(' ');
  for (var element in infixList) {
    if (element == '(') {
      hasOpenParenthesis = true;
      stack.add(builder.open);
      continue;
    }

    if (element == ')') {
      hasOpenParenthesis = false;
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
      lastOperandType:
          result.isNotEmpty ? OperandType.fromString(result.last) : null,
      thereIsOpenParenthesis: hasOpenParenthesis,
      postfixExpression: result);
}
