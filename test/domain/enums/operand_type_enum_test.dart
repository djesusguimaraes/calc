import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/domain/enums/operand_type_enum.dart';

void main() {
  group('Testes de integridade das funções de OperandType enum:', () {
    test('Deve retornar true para o tipo número', () {
      var type = OperandType.number;
      expect(type.isNumber, true);
    });

    test('Deve retornar false para o tipo operador', () {
      var type = OperandType.operator;
      expect(type.isNumber, false);
    });

    test('Deve retornar false para o tipo ponto', () {
      var type = OperandType.dot;
      expect(type.isNumber, false);
    });

    test('Deve retornar true para o tipo ponto', () {
      var type = OperandType.dot;
      expect(type.isDot, true);
    });

    test('Deve retornar false para o tipo número', () {
      var type = OperandType.number;
      expect(type.isDot, false);
    });

    test('Deve retornar false para o tipo operador', () {
      var type = OperandType.operator;
      expect(type.isDot, false);
    });

    test('Deve retornar true para o tipo operador', () {
      var type = OperandType.operator;
      expect(type.isOperator, true);
    });

    test('Deve retornar false para o tipo número', () {
      var type = OperandType.number;
      expect(type.isOperator, false);
    });
  });
}
