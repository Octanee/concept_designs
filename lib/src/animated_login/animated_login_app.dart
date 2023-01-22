import 'package:concept_designs/src/animated_login/animated_login_screen.dart';
import 'package:concept_designs/src/car_app/constants.dart';
import 'package:concept_designs/src/common.dart';

class AnimatedLoginApp extends StatelessWidget {
  const AnimatedLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white38,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding * 1.2,
          ),
        ),
      ),
      child: const AnimatedLoginScreen(),
    );
  }
}
