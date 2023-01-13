import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/universe/planet.dart';
import 'package:concept_designs/src/universe/planet_details_page.dart';
import 'package:concept_designs/src/universe/universe_colors.dart';

class UniversePage extends StatelessWidget {
  const UniversePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.height * 0.04,
        ),
        decoration: BoxDecoration(
          color: UniverseColors.navigationColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/universe/menu_icon.png'),
                const SizedBox(width: 12),
                const Text(
                  'Explore',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Image.asset('assets/universe/search_icon.png'),
            Image.asset('assets/universe/profile_icon.png'),
          ],
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              UniverseColors.gradientStartColor,
              UniverseColors.gradientEndColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.3, 0.7],
          ),
        ),
        child: SafeArea(
          child: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.05,
                      left: size.width * 0.1,
                      right: size.width * 0.1,
                      bottom: size.height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Explore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text(
                              'Solar System',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Image.asset(
                              'assets/universe/drop_down_icon.png',
                              scale: 0.8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: _PlanetView(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanetView extends StatelessWidget {
  const _PlanetView();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: planets.length,
      itemBuilder: (context, index) {
        final planet = planets[index];

        return _PlanetCard(planet: planet);
      },
    );
  }
}

class _PlanetCard extends StatelessWidget {
  const _PlanetCard({required this.planet});

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FadeTransition(
              opacity: animation,
              child: PlanetDetailsPage(
                planet: planet,
              ),
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: size.height * 0.15,
            bottom: size.height * 0.07,
            left: size.width * 0.1,
            right: size.width * 0.1,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.05,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Positioned(
                    right: 0,
                    bottom: -size.height * 0.05,
                    child: Text(
                      planet.position.toString(),
                      style: TextStyle(
                        color: UniverseColors.contentTextColor.withOpacity(0.2),
                        fontSize: size.height * 0.25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            planet.name,
                            style: TextStyle(
                              color: UniverseColors.primaryTextColor,
                              fontSize: size.height * 0.06,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'Solar System',
                            style: TextStyle(
                              color: UniverseColors.primaryTextColor,
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Text(
                            'Know more',
                            style: TextStyle(
                              color: UniverseColors.secondaryTextColor,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color: UniverseColors.secondaryTextColor,
                            size: size.height * 0.03,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Hero(
            tag: '${planet.name}_image',
            child: Image.asset(
              planet.imagePath,
              width: size.width * 0.9,
            ),
          ),
        ],
      ),
    );
  }
}
