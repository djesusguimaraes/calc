import '../enums/operand_type_enum.dart';

class ExpressionStatus {
  final List<String> postfixExpression;
  final OperandType? lastOperandType;
  final bool thereIsOpenParenthesis;

  ExpressionStatus({
    this.lastOperandType,
    this.postfixExpression = const [''],
    this.thereIsOpenParenthesis = false,
  });
}
