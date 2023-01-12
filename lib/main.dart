import 'dart:async';

import 'package:concept_designs/src/app.dart';
import 'package:concept_designs/src/app_bloc_observer.dart';
import 'package:concept_designs/src/common.dart';

Future<void> main() async {
  FlutterError.onError = (details) =>
      logger.e(details.exceptionAsString(), details.exception, details.stack);

  Bloc.observer = AppBlocObserver();

  runZonedGuarded(
    () => runApp(const MyApp()),
    (error, stack) => logger.e(error.toString(), error, stack),
  );
}
