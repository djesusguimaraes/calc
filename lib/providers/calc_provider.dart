import 'package:flutter/material.dart';

class ExpressionChangeNotifier extends ChangeNotifier {
  String expression;
  String result;

  ExpressionChangeNotifier({this.expression = '', this.result = ''});

  void evaluate() {}

  void addValue(String value) {
    expression += ' $value';
    notifyListeners();
  }

  void clear() {
    expression = '';
    notifyListeners();
  }
}
