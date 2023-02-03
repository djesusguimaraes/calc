import 'dart:math';

import '../../domain/models/operators_model.dart';

num evaluateExpression(OperatorsProvider builder, List<String> postFixed) {
  List<num> stack = [];

  for (var element in postFixed) {
    var operator = builder.itsOperator(element);
    if (operator == null) {
      stack.add(num.parse(element));
      continue;
    } else if (stack.isNotEmpty) {
      var second = stack.removeLast();
      if (operator.isBinary) {
        if (stack.isNotEmpty) {
          var first = stack.removeLast();
          stack.add(_evaluateBinaryExpression(first, second, operator.simbol));
        }
      } else {
        stack.add(_evaluateUnaryExpression(second, operator.simbol));
      }
    }
  }

  return stack.first;
}

_evaluateUnaryExpression(num value, String simbol) {
  switch (simbol) {
    case '!':
      num factorial = 1;
      for (int index = 1; index <= value; index++) {
        factorial *= index;
      }
      return factorial;
    case '%':
      return value / 100;
    default:
      return 0;
  }
}

_evaluateBinaryExpression(num first, num second, String simbol) {
  switch (simbol) {
    case '+':
      return first + second;
    case '-':
      return first - second;
    case '*':
      return first * second;
    case '/':
      return first / second;
    case '^':
      return pow(first, second);
    default:
      return 0;
  }
}
