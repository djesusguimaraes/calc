import '../../models/operators_model.dart';

List<String> infixToPostfix(OperatorsBuilder builder, String infix) {
  List<String> result = [];
  List<Operator> stack = [];

  List<String> infixList = infix.split(' ');
  for (var element in infixList) {
    if (element == '(') {
      stack.add(builder.open);
      continue;
    }

    if (element == ')') {
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

  return result;
}
