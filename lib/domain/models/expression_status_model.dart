import '../enums/operand_type_enum.dart';

class ExpressionStatus {
  final List<String> postfixExpression;
  final int openParenthesisCount;
  late final bool isValid;

  ExpressionStatus({
    required this.postfixExpression,
    this.openParenthesisCount = 0,
  }) {
    assert(postfixExpression.isNotEmpty);

    int numberCount = 0;
    int operatorCount = 0;
    for (var element in postfixExpression) {
      OperandType.fromString(element).isOperator
          ? operatorCount++
          : numberCount++;
    }

    isValid = !hasOpenParenthesis &&
        operatorCount < numberCount &&
        OperandType.fromString(postfixExpression.last).isOperator;
  }

  bool get hasOpenParenthesis => openParenthesisCount > 0;
}
