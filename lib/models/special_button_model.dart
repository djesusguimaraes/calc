import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_plays/providers/calc_provider.dart';

import 'button_model.dart';

class SpecialButton extends Button {
  final Color color;
  final IconData? icon;

  SpecialButton({
    required this.color,
    this.icon,
    required String simbol,
    Function()? action,
  }) : super(action: action, simbol: simbol);

  @override
  Widget render(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton(
            onPressed: action ?? () => context.read<ExpressionChangeNotifier>().addValue(simbol),
            foregroundColor: Colors.white,
            backgroundColor: color,
            child: icon != null
                ? Icon(icon)
                : Text(
                    simbol,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  )));
  }
}
