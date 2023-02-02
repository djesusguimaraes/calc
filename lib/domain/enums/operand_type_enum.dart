enum OperandType {
  dot,
  number,
  operator;

  static OperandType fromString(String value) {
    if (num.tryParse(value) != null) return OperandType.number;
    if (value == '.') return OperandType.dot;
    return OperandType.operator;
  }

  bool get isNumber => this == OperandType.number;
  bool get isDot => this == OperandType.dot;
  bool get isOperator => this == OperandType.operator;
}
