import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/travy/bloc/destination_bloc.dart';
import 'package:concept_designs/src/travy/models/category.dart';
import 'package:concept_designs/src/travy/pages/components/components.dart';
import 'package:ionicons/ionicons.dart';

class TravyPage extends StatefulWidget {
  const TravyPage({super.key});

  @override
  State<TravyPage> createState() => _TravyPageState();
}

class _TravyPageState extends State<TravyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DestinationBloc, DestinationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case DestinationStatus.initial:
            case DestinationStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DestinationStatus.loaded:
              return const _HomeView();
            case DestinationStatus.failure:
              return const Center(child: Text('Something gone wrong..'));
          }
        },
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        SizedBox(height: 8),
        _Header(),
        SizedBox(height: 24),
        _SearchBar(),
        SizedBox(height: 24),
        _ChipsRow(),
        SizedBox(height: 24),
        _PopularDestinations(),
        SizedBox(height: 24),
        _NearbyMe(),
        SizedBox(height: 16),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi Emily,',
                style: TextStyle(color: Colors.grey.shade500),
              ),
              const Text(
                'Travelling Today?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(
              'assets/travy/women.jpg',
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Ionicons.search,
            color: Colors.grey.shade500,
          ),
          const SizedBox(width: 8),
          Text(
            'Search destination...',
            style: TextStyle(color: Colors.grey.shade500),
          )
        ],
      ),
    );
  }
}

class _ChipsRow extends StatelessWidget {
  const _ChipsRow();

  @override
  Widget build(BuildContext context) {
    return HorizontalScrollView(
      itemCount: DestinationCategory.values.length,
      itemBuilder: (context, index) => CategoryChip(
        category: DestinationCategory.values[index],
      ),
    );
  }
}

class _PopularDestinations extends StatelessWidget {
  const _PopularDestinations();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationBloc, DestinationState>(
      buildWhen: (previous, current) =>
          previous.popularDestinations() != current.popularDestinations(),
      builder: (context, state) {
        final data = state.popularDestinations();
        return _Section(
          name: 'Popular Destination',
          onTap: () {},
          content: HorizontalScrollView(
            itemCount: data.length,
            itemBuilder: (context, index) => PopularDestinationItem(
              destination: data[index],
            ),
          ),
        );
      },
    );
  }
}

class _NearbyMe extends StatelessWidget {
  const _NearbyMe();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationBloc, DestinationState>(
      buildWhen: (previous, current) =>
          previous.nerbyDestinations() != current.nerbyDestinations(),
      builder: (context, state) {
        final data = state.nerbyDestinations();
        return _Section(
          name: 'Nearby Me',
          onTap: () {},
          content: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: data.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) => NerbyDestination(
              destination: data[index],
            ),
          ),
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.name,
    required this.content,
    required this.onTap,
  });

  final String name;
  final Widget content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }
}
