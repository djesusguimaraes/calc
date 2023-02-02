import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/domain/models/operators_model.dart';

void main() {
  group('Testes de parser de operador', () {
    late OperatorsProvider builder;

    setUp(() {
      builder = OperatorsProvider.fromJson(jsonOperators);
    });

    test('Deve retornar Set<Operator>', () {
      expect(builder.values, isA<Set<Operator>>());
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

    test('Deve retornar false para operador "1"', () {
      expect(builder.isOperator('1'), false);
    });
  });
}
