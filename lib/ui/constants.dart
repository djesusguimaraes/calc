import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final Set<String> buttons = {
  'C',
  '+/-',
  '%',
  '/',
  '7',
  '8',
  '9',
  'x',
  '4',
  '5',
  '6',
  '+',
  '1',
  '2',
  '3',
  '-',
  '( )',
  '0',
  '.',
  '=',
};

final Map<String, dynamic> specialButtons = {
  '/': {'color': Colors.purple, 'icon': FontAwesomeIcons.divide},
  '-': {'color': Colors.lightBlue, 'icon': FontAwesomeIcons.minus},
  '+': {'color': Colors.amber, 'icon': FontAwesomeIcons.plus},
  '=': {'color': Colors.green, 'icon': FontAwesomeIcons.equals},
  'x': {'color': Colors.red, 'icon': FontAwesomeIcons.xmark}
};
