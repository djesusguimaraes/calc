import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_plays/keyboard_widget.dart';
import 'package:ui_plays/providers/calc_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ExpressionChangeNotifier(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const KeyBoard(),
        ));
  }
}
