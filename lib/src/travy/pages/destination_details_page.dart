import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/travy/models/destination.dart';
import 'package:concept_designs/src/travy/pages/components/components.dart';
import 'package:ionicons/ionicons.dart';

class DestinationDetailsPage extends StatefulWidget {
  const DestinationDetailsPage({
    super.key,
    required this.destination,
  });

  final Destination destination;

  @override
  State<DestinationDetailsPage> createState() => _DestinationDetailsPageState();
}

class _DestinationDetailsPageState extends State<DestinationDetailsPage> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _BookNowButton(
        controller: controller,
        height: height,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        slivers: [
          SliverPersistentHeader(
            delegate: _AppBarDelegate(
              destination: widget.destination,
              minExtent: height * 0.3,
              maxExtent: height * 0.6,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: _DestinationDetails(
              destination: widget.destination,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookNowButton extends StatelessWidget {
  const _BookNowButton({
    required this.controller,
    required this.height,
  });

  final ScrollController controller;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ScrollToHideWidget(
      controller: controller,
      height: height * 0.25,
      child: Stack(
        children: [
          const Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white70,
                      Colors.white10,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: height * 0.08,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Book Now!',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DestinationDetails extends StatelessWidget {
  const _DestinationDetails({required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const PeopleReviewed(),
                const SizedBox(width: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      destination.score.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '/5',
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
              ],
            ),
            const TabBar(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 18,
              ),
              labelColor: Colors.black87,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 12),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'Overview'),
                Tab(text: 'Maps'),
                Tab(text: 'Preview'),
              ],
            ),
            Text(
              destination.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 72)
          ],
        ),
      ),
    );
  }
}

class _AppBarDelegate extends SliverPersistentHeaderDelegate {
  const _AppBarDelegate({
    required this.destination,
    required double maxExtent,
    required double minExtent,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;

  final double _maxExtent;
  final double _minExtent;
  final Destination destination;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            destination.imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomHeader(),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Ionicons.location_outline,
                              color: Colors.blue,
                              size: 20,
                            ),
                            Text(
                              destination.localization,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Text(
                          '\$${destination.price.floor()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          '/person',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 24,
          left: 16,
          child: AppBarButton(
            onTap: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.grey[700],
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 24,
          child: AppBarButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.grey[700],
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => _maxExtent;
  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
