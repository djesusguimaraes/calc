import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/domain/models/expression_status_model.dart';

void main() {
  group('Testes de validação de expressão pós-fixa em `ExpressionStatus`:', () {
    test('Deve retornar `true` para uma expressão válida', () {
      var expression = ['1', '2', '+'];
      var status = ExpressionStatus(postfixExpression: expression);
      expect(status.isValid, true);
    });

    test('Deve retornar `false` para uma expressão inválida `1 +`', () {
      var expression = ['1', '+'];
      var status = ExpressionStatus(postfixExpression: expression);
      expect(status.isValid, false);
    });

    test('Deve retornar `false` para uma expressão inválida `1.2 + ( - 3 )`',
        () {
      var expression = ['1.2', '+', '(', '-', '3', ')'];
      var status = ExpressionStatus(postfixExpression: expression);
      expect(status.isValid, false);
    });
  });
}
