import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/travy/bloc/destination_bloc.dart';
import 'package:concept_designs/src/travy/data/destination_repository.dart';
import 'package:concept_designs/src/travy/pages/travy_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

class TravyNav extends StatefulWidget {
  const TravyNav({super.key});

  @override
  State<TravyNav> createState() => _TravyNavState();
}

class _TravyNavState extends State<TravyNav> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DestinationBloc(
        destinationRepository: DestinationRepository(),
      )..add(const DestinationLoading()),
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            TravyPage(),
            Scaffold(),
            Scaffold(),
            Scaffold(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          onTap: (index) => setState(() => currentIndex = index),
          index: currentIndex,
          animationDuration: const Duration(milliseconds: 300),
          items: [
            _buildItem(
              index: 0,
              icon: Ionicons.home_outline,
              activeIcon: Ionicons.home,
            ),
            _buildItem(
              index: 1,
              icon: Ionicons.heart_outline,
              activeIcon: Ionicons.heart,
            ),
            _buildItem(
              index: 2,
              icon: Ionicons.compass_outline,
              activeIcon: Ionicons.compass,
            ),
            _buildItem(
              index: 3,
              icon: Ionicons.settings_outline,
              activeIcon: Ionicons.settings,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
  }) {
    return currentIndex == index
        ? Icon(
            activeIcon,
            color: Colors.blue,
          )
        : Icon(icon);
  }
}
