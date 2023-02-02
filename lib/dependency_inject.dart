import 'package:get_it/get_it.dart';
import 'package:ui_plays/domain/models/operators_model.dart';

void initDependencies() {
  GetIt.instance.registerSingleton<OperatorsBuilder>(OperatorsBuilder.fromJson(jsonOperators));
}
