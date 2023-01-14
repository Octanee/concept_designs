import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/super_hero/models/super_hero.dart';
import 'package:ionicons/ionicons.dart';

class SuperHeroDetaisPage extends StatelessWidget {
  const SuperHeroDetaisPage({super.key, required this.superHero});

  final SuperHero superHero;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final color = superHero.color;
    final hsl = HSLColor.fromColor(color);
    final darkColor = hsl.withLightness(hsl.lightness - 0.25).toColor();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Ionicons.close,
            size: 32,
          ),
        ),
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: '${superHero.name}_background',
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        color,
                        darkColor,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      superHero.name,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          superHero.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: size.height * 0.1,
              right: size.width * 0.1,
              child: Hero(
                tag: '${superHero.name}_image',
                child: Image.asset(
                  superHero.imagePath,
                  height: size.height * 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
