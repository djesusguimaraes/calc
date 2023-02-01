import 'package:flutter_test/flutter_test.dart';
import 'package:ui_plays/utils/mark_thousand_util.dart';

void main() {
  group('Teste de função de formatação de texto por milhares', () {
    test('Deve retornar uma string com vírgulas entre os milhares', () {
      expect(markThousand('123456789'), '123,456,789');
    });

    test(
        'Deve retornar uma string com vírgulas entre os milhares sem alterar decimais',
        () {
      expect(markThousand('123456789.123549594'), '123,456,789.123549594');
    });

    test('Deve retornar retornar a string original se não houver milhares', () {
      expect(markThousand('12.3'), '12.3');
    });
  });
}
