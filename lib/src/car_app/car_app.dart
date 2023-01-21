import 'package:concept_designs/src/car_app/screens/home_screen.dart';
import 'package:concept_designs/src/common.dart';

class CarApp extends StatelessWidget {
  const CarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        // canvasColor: Colors.black,
      ),
      child: const HomeScreen(),
    );
  }
}
