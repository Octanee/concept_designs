import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/fika_coffee/pages/fika_coffee_page.dart';
import 'package:concept_designs/src/travy/travy_nav.dart';

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
