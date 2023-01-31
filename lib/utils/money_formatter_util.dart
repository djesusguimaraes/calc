import 'package:money_formatter/money_formatter.dart';

moneyFormat(String value, {bool withDecimal = false}) {
  var fo = MoneyFormatter(amount: double.parse(value)).output;
  return withDecimal ? fo.nonSymbol : fo.withoutFractionDigits;
}
