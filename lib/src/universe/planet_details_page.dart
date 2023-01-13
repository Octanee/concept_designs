import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/universe/planet.dart';
import 'package:concept_designs/src/universe/universe_colors.dart';

class PlanetDetailsPage extends StatelessWidget {
  const PlanetDetailsPage({super.key, required this.planet});

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: UniverseColors.primaryTextColor),
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            delegate: _AppBarDelegate(
              planet: planet,
              size: size,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  height: size.height * 0.025,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
                const _CustomDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Text(
                    planet.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: UniverseColors.contentTextColor,
                    ),
                  ),
                ),
                const _CustomDivider(),
                Visibility(
                  visible: planet.images.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                            color: UniverseColors.primaryTextColor,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      _HorizontalScrollView(
                        itemCount: planet.images.length,
                        itemBuilder: (context, index) {
                          final path = planet.images[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              path,
                              height: size.height * 0.2,
                            ),
                          );
                        },
                      ),
                      const _CustomDivider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Divider(
      height: 32,
      thickness: 4,
      color: UniverseColors.primaryTextColor.withOpacity(0.1),
      indent: size.width * 0.1,
      endIndent: size.width * 0.1,
    );
  }
}

class _AppBarDelegate extends SliverPersistentHeaderDelegate {
  const _AppBarDelegate({
    required this.planet,
    required this.size,
  });

  final Planet planet;
  final Size size;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      children: [
        Positioned(
          left: size.width * 0.1,
          top: size.height * 0.1,
          child: Text(
            planet.position.toString(),
            style: TextStyle(
              color: UniverseColors.contentTextColor.withOpacity(0.2),
              fontSize: size.height * 0.25,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.05,
          right: -size.width * 0.2,
          child: Hero(
            tag: '${planet.name}_image',
            child: Image.asset(
              planet.imagePath,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: size.width * 0.1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planet.name,
                style: TextStyle(
                  color: UniverseColors.primaryTextColor,
                  fontSize: size.height * 0.09,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Solar System',
                style: TextStyle(
                  color: UniverseColors.primaryTextColor,
                  fontSize: size.height * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => size.height * 0.5;
  @override
  double get minExtent => size.height * 0.3;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _HorizontalScrollView extends StatelessWidget {
  const _HorizontalScrollView({
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 12),
      child: Row(
        children: List.generate(
          itemCount,
          (index) => Padding(
            padding: index != itemCount - 1
                ? const EdgeInsets.only(right: 8)
                : EdgeInsets.zero,
            child: itemBuilder(context, index),
          ),
        ),
      ),
    );
  }
}
