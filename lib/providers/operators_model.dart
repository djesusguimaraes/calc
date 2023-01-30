abstract class Operators {
  final String? simbol;
  final void Function() action;

  Operators({this.simbol, required this.action});
}

class EqualOperator extends Operators {
  EqualOperator({required super.action});
}
