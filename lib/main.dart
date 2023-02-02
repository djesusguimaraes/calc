import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ui_plays/dependency_inject.dart';
import 'package:ui_plays/providers/calc_provider.dart';
import 'package:ui_plays/ui/keyboard_widget.dart';

import 'domain/models/operators_model.dart';

void main() {
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return FutureBuilder(
        future: getIt.allReady(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider(
                create: (context) => ExpressionChangeNotifier(getIt.get<OperatorsBuilder>()),
                child: const MaterialApp(debugShowCheckedModeBanner: false, home: KeyBoard()));
          }
          return const MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator())));
        });
  }
}
