import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

final logger = Logger(printer: PrettyPrinter());

extension CustomContext on BuildContext {
  void push<T extends Object?>({required Widget page}) {
    Navigator.of(this).push(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
    );
  }

  void pop<T extends Object?>({T? result}) {
    Navigator.of(this).pop(result);
  }
}
