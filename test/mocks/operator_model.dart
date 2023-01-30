class Operator {
  final String simbol;
  final int precedence;
  final bool isBinary;

  Operator({required this.simbol, this.precedence = 0, this.isBinary = true});

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      simbol: json['simbol'],
      precedence: json.containsKey('precedence') ? json['precedence'] : null,
      isBinary: json.containsKey('is_binary') ? json['is_binary'] : null,
    );
  }
}
