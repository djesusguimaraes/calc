import 'operator_model.dart';

class OperatorsBuilder {
  final Set<Operator> values;
  Set<String>? simbols;

  Operator open = Operator(simbol: '(', precedence: 0, isBinary: false);
  Operator closed = Operator(simbol: ')', precedence: 0, isBinary: false);

  OperatorsBuilder(this.values, {this.simbols});

  factory OperatorsBuilder.fromJson(Map<String, dynamic> json) {
    Set<Operator> values = {};
    Set<String> simbols = {};
    if (json.containsKey('operators') && (json['operators'] as List).isNotEmpty) {
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
