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

class OperatorsBuilder {
  final Set<Operator> values;
  Set<String>? simbols;

  Operator open = Operator(simbol: '(', precedence: 0, isBinary: false);
  Operator closed = Operator(simbol: ')', precedence: 0, isBinary: false);

  OperatorsBuilder(this.values, {this.simbols});

  factory OperatorsBuilder.fromJson(Map<String, dynamic> json) {
    Set<Operator> values = {};
    Set<String> simbols = {};
    if (json.containsKey('operators') &&
        (json['operators'] as List).isNotEmpty) {
      for (var operator in (json['operators'] as List)) {
        values.add(Operator.fromJson(operator));
        simbols.add(operator['simbol']);
      }
    }
    return OperatorsBuilder(values, simbols: simbols);
  }

  Operator? itsOperator(String simbol) {
    if (simbols!.contains(simbol)) {
      return values.firstWhere((element) => element.simbol == simbol);
    }
    return null;
  }
}

var jsonOperators = {
  'operators': [
    {'simbol': '+', 'precedence': 1, 'is_binary': true},
    {'simbol': '*', 'precedence': 2, 'is_binary': true},
    {'simbol': '-', 'precedence': 1, 'is_binary': true},
    {'simbol': '/', 'precedence': 2, 'is_binary': true},
    {'simbol': '%', 'precedence': 3, 'is_binary': false},
    {'simbol': '!', 'precedence': 3, 'is_binary': false},
    {'simbol': '^', 'precedence': 3, 'is_binary': true},
  ]
};
