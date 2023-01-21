import 'package:concept_designs/src/car_app/constants.dart';
import 'package:concept_designs/src/car_app/home_controller.dart';
import 'package:concept_designs/src/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late HomeController _homeController;

  late AnimationController _batteryAnimationController;
  late Animation<double> _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;

  late AnimationController _temperatureAnimationController;
  late Animation<double> _carShiftAnimation;
  late Animation<double> _temperatureDetailsAnimation;
  late Animation<double> _coolingGlowAnimation;

  late AnimationController _tyreController;
  late Animation<double> _tyreAnimation;
  late Animation<double> _tyrePresureAnimation;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController();
    _setupBatteryAnimation();
    _setupTemperatureAnimation();
    _setupTyreAnimation();
  }

  void _setupTyreAnimation() {
    _tyreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _tyreAnimation = CurvedAnimation(
      parent: _tyreController,
      curve: const Interval(0.2, 0.5),
    );
    _tyrePresureAnimation = CurvedAnimation(
      parent: _tyreController,
      curve: const Interval(0.55, 0.75),
    );
  }

  void _setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    _batteryAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0, 0.5),
    );
    _batteryStatusAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  void _setupTemperatureAnimation() {
    _temperatureAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );
    _carShiftAnimation = CurvedAnimation(
      parent: _temperatureAnimationController,
      curve: const Interval(0.2, 0.4),
    );
    _temperatureDetailsAnimation = CurvedAnimation(
      parent: _temperatureAnimationController,
      curve: const Interval(0.45, 0.65),
    );
    _coolingGlowAnimation = CurvedAnimation(
      parent: _temperatureAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _temperatureAnimationController.dispose();
    _tyreController.dispose();
    super.dispose();
  }

  void _onNavigationBarTap(NavigationTab tab) {
    if (tab == NavigationTab.charge) {
      _batteryAnimationController.forward();
    } else if (_homeController.selectedNavigationTab == NavigationTab.charge &&
        tab != NavigationTab.charge) {
      _batteryAnimationController.reverse(from: 0.4);
    }

    if (tab == NavigationTab.temperature) {
      _temperatureAnimationController.forward();
    } else if (_homeController.selectedNavigationTab ==
            NavigationTab.temperature &&
        tab != NavigationTab.temperature) {
      _temperatureAnimationController.reverse(from: 0.6);
    }

    if (tab == NavigationTab.tyre) {
      _tyreController.forward();
    } else if (_homeController.selectedNavigationTab == NavigationTab.tyre &&
        tab != NavigationTab.tyre) {
      _tyreController.reverse(from: 0.5);
    }

    _homeController.onNavigationTabChange(tab);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _homeController,
        _batteryAnimationController,
        _temperatureAnimationController,
        _tyreController,
      ]),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: _CarBottomBar(
            selectedTab: _homeController.selectedNavigationTab,
            onTap: _onNavigationBarTap,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    _Car(
                      constraints: constraints,
                      carShiftAnimation: _carShiftAnimation,
                      homeController: _homeController,
                      batteryAnimation: _batteryAnimation,
                      tyreAnimation: _tyreAnimation,
                    ),

                    // Battery Status
                    Positioned(
                      top: 50 * (1 - _batteryStatusAnimation.value),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Opacity(
                        opacity: _batteryStatusAnimation.value,
                        child: const _BatteryStatus(),
                      ),
                    ),

                    // Temperature
                    Positioned(
                      top: 50 * (1 - _temperatureDetailsAnimation.value),
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: Opacity(
                        opacity: _temperatureDetailsAnimation.value,
                        child: _TemperatureDetails(
                          homeController: _homeController,
                        ),
                      ),
                    ),

                    Positioned(
                      right: (-constraints.maxWidth / 2) *
                          (1 - _coolingGlowAnimation.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _homeController.isCoolingSelected
                            ? Image.asset(
                                'assets/car_app/cooling_glow.png',
                                key: const ValueKey('cooling_glow'),
                                width: constraints.maxWidth / 2.5,
                              )
                            : Image.asset(
                                'assets/car_app/heating_glow.png',
                                key: const ValueKey('heating_glow'),
                                width: constraints.maxWidth / 2.5,
                              ),
                      ),
                    ),

                    IgnorePointer(
                      ignoring: _homeController.selectedNavigationTab !=
                          NavigationTab.tyre,
                      child: Opacity(
                        opacity: _tyrePresureAnimation.value,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: defaultPadding,
                            mainAxisSpacing: defaultPadding,
                            childAspectRatio:
                                constraints.maxWidth / constraints.maxHeight,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) => _PresureItem(
                            pressure: _homeController.tyrePsi[index],
                            index: index,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _PresureItem extends StatelessWidget {
  const _PresureItem({
    required this.pressure,
    required this.index,
  });

  final double pressure;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isLowPressure = pressure <= 32;

    final children = [
      Text(
        '${pressure.toStringAsFixed(1)}psi',
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: defaultPadding),
      const Text(
        '56\u2103',
        style: TextStyle(fontSize: 16),
      ),
      const Spacer(),
      Visibility(
        visible: isLowPressure,
        child: Column(
          crossAxisAlignment: index == 1 || index == 3
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: const [
            Text(
              'LOW',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'PRESSURE',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(
          color: isLowPressure ? redColor : primaryColor,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isLowPressure ? redColor.withOpacity(0.1) : Colors.white10,
      ),
      child: Column(
        crossAxisAlignment: index == 1 || index == 3
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children:
            index == 2 || index == 3 ? children.reversed.toList() : children,
      ),
    );
  }
}

class _Car extends StatelessWidget {
  const _Car({
    required BoxConstraints constraints,
    required HomeController homeController,
    required Animation<double> carShiftAnimation,
    required Animation<double> batteryAnimation,
    required Animation<double> tyreAnimation,
  })  : _constraints = constraints,
        _homeController = homeController,
        _carShiftAnimation = carShiftAnimation,
        _batteryAnimation = batteryAnimation,
        _tyreAnimation = tyreAnimation;

  final BoxConstraints _constraints;

  final HomeController _homeController;

  final Animation<double> _carShiftAnimation;
  final Animation<double> _batteryAnimation;
  final Animation<double> _tyreAnimation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _constraints.maxWidth / 2 * _carShiftAnimation.value,
      height: _constraints.maxHeight,
      width: _constraints.maxWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _constraints.maxHeight * 0.1,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            getSvg('car.svg', width: double.maxFinite),
            // Door Locks
            AnimatedPositioned(
              duration: defaultDuration,
              left: _homeController.selectedNavigationTab == NavigationTab.lock
                  ? _constraints.maxWidth * 0.05
                  : _constraints.maxWidth / 2,
              child: AnimatedOpacity(
                duration: defaultDuration,
                opacity:
                    _homeController.selectedNavigationTab == NavigationTab.lock
                        ? 1
                        : 0,
                child: _DoorLockButton(
                  onTap: _homeController.updateLeftDoorLock,
                  isLock: _homeController.isLeftDoorLock,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: defaultDuration,
              right: _homeController.selectedNavigationTab == NavigationTab.lock
                  ? _constraints.maxWidth * 0.05
                  : _constraints.maxWidth / 2,
              child: AnimatedOpacity(
                duration: defaultDuration,
                opacity:
                    _homeController.selectedNavigationTab == NavigationTab.lock
                        ? 1
                        : 0,
                child: _DoorLockButton(
                  onTap: _homeController.updateRightDoorLock,
                  isLock: _homeController.isRightDoorLock,
                ),
              ),
            ),
            // Bonnet Lock
            AnimatedPositioned(
              duration: defaultDuration,
              top: _homeController.selectedNavigationTab == NavigationTab.lock
                  ? _constraints.maxHeight * 0.05
                  : _constraints.maxHeight / 2,
              child: AnimatedOpacity(
                duration: defaultDuration,
                opacity:
                    _homeController.selectedNavigationTab == NavigationTab.lock
                        ? 1
                        : 0,
                child: _DoorLockButton(
                  onTap: _homeController.updateBonnetLock,
                  isLock: _homeController.isBonnetLock,
                ),
              ),
            ),
            // Trunk Lock
            AnimatedPositioned(
              duration: defaultDuration,
              bottom:
                  _homeController.selectedNavigationTab == NavigationTab.lock
                      ? _constraints.maxHeight * 0.08
                      : _constraints.maxHeight / 2,
              child: AnimatedOpacity(
                duration: defaultDuration,
                opacity:
                    _homeController.selectedNavigationTab == NavigationTab.lock
                        ? 1
                        : 0,
                child: _DoorLockButton(
                  onTap: _homeController.updateTrunkLock,
                  isLock: _homeController.isTrunkLock,
                ),
              ),
            ),
            // Battery
            Opacity(
              opacity: _batteryAnimation.value,
              child: getSvg(
                'battery.svg',
                width: _constraints.maxWidth * 0.4,
              ),
            ),
            Opacity(
              opacity: _tyreAnimation.value,
              child: Stack(
                children: [
                  Positioned(
                    left: _constraints.maxWidth * 0.22,
                    top: _constraints.maxHeight * 0.11,
                    child: getSvg('car_tyre.svg'),
                  ),
                  Positioned(
                    right: _constraints.maxWidth * 0.22,
                    top: _constraints.maxHeight * 0.11,
                    child: getSvg('car_tyre.svg'),
                  ),
                  Positioned(
                    right: _constraints.maxWidth * 0.215,
                    bottom: _constraints.maxHeight * 0.14,
                    child: getSvg('car_tyre.svg'),
                  ),
                  Positioned(
                    left: _constraints.maxWidth * 0.215,
                    bottom: _constraints.maxHeight * 0.14,
                    child: getSvg('car_tyre.svg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TemperatureDetails extends StatelessWidget {
  const _TemperatureDetails({
    required HomeController homeController,
  }) : _homeController = homeController;

  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 125,
            child: Row(
              children: [
                _TemperatureButton(
                  assetPath: 'cooling.svg',
                  text: 'Cool',
                  activeColor: primaryColor,
                  isActive: _homeController.isCoolingSelected,
                  onTap: _homeController.updateCoolingSelected,
                ),
                const SizedBox(width: defaultPadding),
                _TemperatureButton(
                  assetPath: 'heat.svg',
                  text: 'Heat',
                  activeColor: redColor,
                  isActive: !_homeController.isCoolingSelected,
                  onTap: _homeController.updateCoolingSelected,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => _homeController.updateTemperature(1),
                icon: const Icon(
                  Icons.arrow_drop_up,
                  size: 48,
                ),
              ),
              Text(
                '${_homeController.temperature}\u2103',
                style: const TextStyle(fontSize: 96),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => _homeController.updateTemperature(-1),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 48,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            'CURRENT TEMPERATURE',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('INSIDE'),
                  Text(
                    '20\u2103',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(width: defaultPadding),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'OUTSIDE',
                    style: TextStyle(color: Colors.white38),
                  ),
                  Text(
                    '32\u2103',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TemperatureButton extends StatelessWidget {
  const _TemperatureButton({
    required this.assetPath,
    required this.text,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  final String assetPath;
  final String text;

  final bool isActive;
  final Color activeColor;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: defaultDuration,
            curve: Curves.easeInOutBack,
            height: isActive ? 76 : 48,
            width: isActive ? 76 : 48,
            child: getSvg(
              assetPath,
              color: isActive ? activeColor : Colors.white38,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: isActive ? 20 : 16,
              color: isActive ? activeColor : Colors.white38,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(
              text.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BatteryStatus extends StatelessWidget {
  const _BatteryStatus();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '220 mi',
          style: TextStyle(fontSize: 48),
        ),
        const Text(
          '62%',
          style: TextStyle(fontSize: 24),
        ),
        const Spacer(),
        const Text(
          'CHARGING',
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          '17 min remaining',
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding / 2,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('22 mi/hr'),
                Text('232 v'),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}

class _CarBottomBar extends StatelessWidget {
  const _CarBottomBar({
    required this.selectedTab,
    required this.onTap,
  });

  final NavigationTab selectedTab;
  final ValueChanged<NavigationTab> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => onTap(NavigationTab.values[index]),
      currentIndex: NavigationTab.values.indexOf(selectedTab),
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: List.generate(NavigationTab.values.length, _buildItem),
    );
  }

  BottomNavigationBarItem _buildItem(int index) {
    final tab = NavigationTab.values[index];
    return BottomNavigationBarItem(
      icon: getSvg(
        tab.assetName,
        color: _getColor(index),
      ),
      label: '',
    );
  }

  Color _getColor(int index) {
    return NavigationTab.values.indexOf(selectedTab) == index
        ? primaryColor
        : Colors.white54;
  }
}

class _DoorLockButton extends StatelessWidget {
  const _DoorLockButton({
    required this.onTap,
    this.isLock = true,
  });

  final VoidCallback onTap;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: isLock
            ? getSvg(
                'door_lock.svg',
                key: const ValueKey('door_lock'),
                color: redColor,
              )
            : getSvg(
                'door_unlock.svg',
                key: const ValueKey('door_unlock'),
                color: primaryColor,
              ),
      ),
    );
  }
}
