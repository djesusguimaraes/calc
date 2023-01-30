import 'package:flutter/material.dart';

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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  "Tela",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
                ),
              ]),
        ),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: .8),
            itemBuilder: (_, index) => _buttonsInstances.elementAt(index).render(),
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
  Widget render() {
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

  Widget render() => IconButton(
      onPressed: action,
      icon: Text(simbol,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          )));
}
