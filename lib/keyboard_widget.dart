import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_plays/providers/calc_provider.dart';

class KeyBoard extends StatefulWidget {
  const KeyBoard({super.key});

  @override
  State<KeyBoard> createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  final Map<String, Color> _specialButtons = {
    '/': Colors.purple,
    '-': Colors.lightBlue,
    '+': Colors.amber,
    '=': Colors.green,
    'x': Colors.red
  };

  late Map<String, void Function()> customActions;

  final Set<String> _buttons = {
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
    '0',
    '.',
    '( )',
    '=',
  };

  late Set<_Button> _buttonsInstances;

  @override
  void initState() {
    customActions = {};

    _buttonsInstances = _buttons.map((e) {
      if (_specialButtons.keys.contains(e)) {
        return _EspecialButton(color: _specialButtons[e]!, simbol: e);
      }
      return _Button(simbol: e);
    }).toSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
            child: Container(
          color: Colors.grey.shade200,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Consumer<ExpressionChangeNotifier>(
                builder: (context, value, child) => Text(value.expression,
                    textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 36)))
          ]),
        )),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: .8),
            itemBuilder: (_, index) => _buttonsInstances.elementAt(index).render(context),
            itemCount: _buttonsInstances.length),
      ]),
    );
  }
}

class _EspecialButton extends _Button {
  final Color color;

  _EspecialButton({
    required this.color,
    required String simbol,
    Function()? action,
  }) : super(action: action, simbol: simbol);

  @override
  Widget render(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton(
            onPressed: action,
            foregroundColor: Colors.white,
            backgroundColor: color,
            child: Text(
              simbol,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            )));
  }
}

class _Button {
  final String simbol;
  final Function()? action;

  _Button({
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
