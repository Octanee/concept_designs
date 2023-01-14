import 'dart:math' as math;

import 'package:ionicons/ionicons.dart';

import '../common.dart';
import 'models/super_hero.dart';
import 'super_hero_details_page.dart';

class SuperHeroPage extends StatelessWidget {
  const SuperHeroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Positioned(
            //   top: 24,
            //   right: 24,
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Ionicons.search),
            //   ),
            // ),
            // const Padding(
            //   padding:
            //       EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 32),
            //   child: Text(
            //     'Marvel',
            //     style: TextStyle(
            //       fontSize: 48,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 24, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Marvel',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.search),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: superHeroes.length,
                itemBuilder: (context, index) {
                  final superHero = superHeroes[index];

                  return _SuperHero(superHero: superHero);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuperHero extends StatelessWidget {
  const _SuperHero({required this.superHero});

  final SuperHero superHero;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final color = superHero.color;
    final hsl = HSLColor.fromColor(color);
    final darkColor = hsl.withLightness(hsl.lightness - 0.25).toColor();

    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<void>(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: animation,
                child: SuperHeroDetaisPage(
                  superHero: superHero,
                ),
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: size.height * 0.5,
              child: Hero(
                tag: '${superHero.name}_background',
                child: ClipPath(
                  clipper: _BackgroundClipper(),
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
            ),
            Positioned(
              bottom: size.height * 0.475,
              right: size.width * 0.01,
              child: Transform.rotate(
                alignment: Alignment.bottomRight,
                angle: -math.pi / 2,
                child: FittedBox(
                  child: Text(
                    superHero.realName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.2,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.1,
              child: Hero(
                tag: '${superHero.name}_image',
                child: Image.asset(
                  superHero.imagePath,
                  height: size.height * 0.6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      superHero.name,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Click to Read More',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height * 0.22)
      ..cubicTo(
        0,
        size.height * 0.19,
        size.width * 0.03,
        size.height * 0.16,
        size.width * 0.07,
        size.height * 0.15,
      )
      ..cubicTo(
        size.width * 0.07,
        size.height * 0.15,
        size.width * 0.9,
        0,
        size.width * 0.9,
        0,
      )
      ..cubicTo(
        size.width * 0.95,
        -0.01,
        size.width,
        size.height * 0.03,
        size.width,
        size.height * 0.07,
      )
      ..cubicTo(
        size.width,
        size.height * 0.07,
        size.width,
        size.height * 0.94,
        size.width,
        size.height * 0.94,
      )
      ..cubicTo(
        size.width,
        size.height * 0.97,
        size.width * 0.96,
        size.height,
        size.width * 0.92,
        size.height,
      )
      ..cubicTo(
        size.width * 0.92,
        size.height,
        size.width * 0.08,
        size.height,
        size.width * 0.08,
        size.height,
      )
      ..cubicTo(
        size.width * 0.04,
        size.height,
        0,
        size.height * 0.97,
        0,
        size.height * 0.94,
      )
      ..cubicTo(
        0,
        size.height * 0.94,
        0,
        size.height * 0.22,
        0,
        size.height * 0.22,
      )
      ..cubicTo(
        0,
        size.height * 0.22,
        0,
        size.height * 0.22,
        0,
        size.height * 0.22,
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
