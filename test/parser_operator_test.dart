import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/models/operators_model.dart';

void main() {
  group('Testes de parser de operador', () {
    late OperatorsBuilder builder;

    setUp(() {
      builder = OperatorsBuilder.fromJson(jsonOperators);
    });

    test('Deve retornar Set<Operator>', () {
      expect(builder.values, isA<Set<Operator>>());
    });

    test('Deve retornar Set<Operator> com 6 instâncias', () {
      expect(builder.values.length, 6);
    });

    test(
        'As instâncias devem corresponder as precedências do conjunto de dados',
        () {
      List<int> dataPrecedences = [];
      for (var operator in (jsonOperators['operators'] as List)) {
        dataPrecedences.add(operator['precedence']);
      }

      List<int> builderPrecedences = [];
      for (var operator in builder.values) {
        builderPrecedences.add(operator.precedence);
      }

      expect(dataPrecedences, builderPrecedences);
    });
  });
}
