import 'package:flutter_test/flutter_test.dart';

import 'mocks/operator_model.dart';
import 'mocks/operators_builder.dart';
import 'mocks/operators_json.dart';

void main() {
  group('Testes de parser de operador', () {
    late OperatorsBuilder builder;

    setUp(() {
      builder = OperatorsBuilder.fromJson(json);
    });

    test('Deve retornar Set<Operator>', () {
      expect(builder.values, isA<Set<Operator>>());
    });

    test('Deve retornar Set<Operator> com 8 instâncias', () {
      expect(builder.values.length, 8);
    });

    test('As instâncias devem corresponder as precedências do conjunto de dados', () {
      List<int> dataPrecedences = [];
      for (var operator in (json['operators'] as List)) {
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
