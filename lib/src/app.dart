import 'package:concept_designs/src/animated_login/animated_login_app.dart';
import 'package:concept_designs/src/car_app/car_app.dart';
import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/custom_buttons/custom_buttons.dart';
import 'package:concept_designs/src/custom_drawer/custom_drawer_app.dart';
import 'package:concept_designs/src/custom_snackbar/custom_snackbar_page.dart';
import 'package:concept_designs/src/fika_coffee/pages/fika_coffee_page.dart';
import 'package:concept_designs/src/nike_store/nike_store.dart';
import 'package:concept_designs/src/super_hero/super_hero_page.dart';
import 'package:concept_designs/src/travy/travy_nav.dart';
import 'package:concept_designs/src/universe/universe_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _MyView(),
    );
  }
}

class _MyView extends StatelessWidget {
  const _MyView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            _buildButton(
              context: context,
              page: const TravyNav(),
              name: 'Travy',
            ),
            _buildButton(
              context: context,
              page: const FikaCoffeePage(),
              name: 'Fika Coffee',
            ),
            _buildButton(
              context: context,
              page: const CustomSnackbarPage(),
              name: 'Custom Snackbar',
            ),
            _buildButton(
              context: context,
              page: const UniversePage(),
              name: 'Universe',
            ),
            _buildButton(
              context: context,
              page: const SuperHeroPage(),
              name: 'Super Hero',
            ),
            _buildButton(
              context: context,
              page: const CarApp(),
              name: 'Car App',
            ),
            _buildButton(
              context: context,
              page: const AnimatedLoginApp(),
              name: 'Animated login',
            ),
            _buildButton(
              context: context,
              page: CustomDrawerApp(),
              name: 'Custom drawer',
            ),
            _buildButton(
              context: context,
              page: const NikeStore(),
              name: 'Nike Store',
            ),
            _buildButton(
              context: context,
              page: const CustomButtons(),
              name: 'Custom Buttons',
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildButton({
    required BuildContext context,
    required Widget page,
    required String name,
  }) {
    return ElevatedButton(
      onPressed: () => context.push(page: page),
      child: Text(name),
    );
  }
}
