import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/calc_provider.dart';

class Button {
  final String simbol;
  final Function()? action;

  Button({
    required this.simbol,
    this.action,
  });

  Widget render(BuildContext context) => IconButton(
      onPressed: action ?? () => Provider.of<ExpressionChangeNotifier>(context, listen: false).addValue(simbol),
      icon: Text(simbol,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          )));
}
