import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/fika_coffee/bloc/coffee_bloc.dart';
import 'package:concept_designs/src/fika_coffee/pages/coffee_list_page.dart';

class CoffeeHome extends StatelessWidget {
  const CoffeeHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<CoffeeBloc, CoffeeState>(
        buildWhen: (previous, current) => previous.coffee != current.coffee,
        builder: (context, state) {
          final data = state.coffee;
          return GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta! < -10) {
                Navigator.of(context).push(
                  PageRouteBuilder<void>(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FadeTransition(
                      opacity: animation,
                      child: CoffeeListPage(coffee: data),
                    ),
                  ),
                );
              }
            },
            child: Stack(
              children: [
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFA89276), Colors.white],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: size.height * 0.15,
                  height: size.height * 0.4,
                  child: Hero(
                    tag: data[6].imagePath,
                    child: Image.asset(data[6].imagePath),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: size.height * 0.7,
                  child: Hero(
                    tag: data[7].imagePath,
                    child: Image.asset(
                      data[7].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -size.height * 0.8,
                  height: size.height,
                  child: Hero(
                    tag: data[8].imagePath,
                    child: Image.asset(
                      data[8].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  height: size.height * 0.2,
                  left: 0,
                  right: 0,
                  bottom: size.height * 0.25,
                  child: Image.asset('assets/fika_coffee/logo.png'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
