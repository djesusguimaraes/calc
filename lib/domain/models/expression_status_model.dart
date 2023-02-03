import '../enums/operand_type_enum.dart';

class ExpressionStatus {
  final List<String> postfixExpression;
  final OperandType? lastOperandType;
  final int openParenthesisCount;

  ExpressionStatus({
    this.lastOperandType,
    this.postfixExpression = const [''],
    this.openParenthesisCount = 0,
  });

  bool get hasOpenParenthesis => openParenthesisCount > 0;
}
