import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_plays/providers/calc_provider.dart';

import '../models/button_model.dart';
import '../models/special_button_model.dart';
import 'constants.dart';

class KeyBoard extends StatefulWidget {
  const KeyBoard({super.key});

  @override
  State<KeyBoard> createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  late Map<String, void Function()> customActions;

  late Set<Button> _buttonsInstances;

  @override
  void didChangeDependencies() {
    _buttonsInstances = _buildButtons();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var notifier = context.read<ExpressionChangeNotifier>();
    return Scaffold(
        body: SafeArea(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: Colors.grey.shade200,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Flexible(
                    flex: 2,
                    child: Consumer<ExpressionChangeNotifier>(
                        builder: (context, value, child) => TextField(
                            textAlign: TextAlign.end,
                            decoration: const InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(text: value.expressionString),
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 36)))),
                Flexible(
                    flex: 3,
                    child: Consumer<ExpressionChangeNotifier>(
                        builder: (context, value, child) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              Text(value.result,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 24)),
                            ]))))
              ]))),
      Container(
          color: Colors.grey.shade200,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
                onPressed: context.watch<ExpressionChangeNotifier>().expression.isNotEmpty ? notifier.backSpace : null,
                icon: const Icon(Icons.backspace_outlined, size: 16),
                padding: const EdgeInsets.fromLTRB(16, 20, 24, 16))
          ])),
      GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: .89),
          itemBuilder: (_, index) => _buttonsInstances.elementAt(index).render(context),
          itemCount: _buttonsInstances.length),
    ])));
  }

  Set<Button> _buildButtons() {
    var notifier = context.read<ExpressionChangeNotifier>();
    customActions = {
      'C': () => notifier.clear(),
      '=': () => notifier.evaluate(),
      'x': () => notifier.addValue('*'),
      '+/-': () => notifier.changeSign(),
      '( )': () => notifier.addParenthesis(),
    };

    return buttons.map((e) {
      var customAction = customActions.containsKey(e) ? customActions[e] : null;
      if (specialButtons.keys.contains(e)) {
        return SpecialButton(
          simbol: e,
          action: customAction,
          icon: specialButtons[e]!['icon'],
          color: specialButtons[e]!['color'],
        );
      }
      return Button(simbol: e, action: customAction);
    }).toSet();
  }
}
