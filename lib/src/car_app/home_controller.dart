import 'package:concept_designs/src/common.dart';

// Use for logical part of app
class HomeController extends ChangeNotifier {
  NavigationTab selectedNavigationTab = NavigationTab.lock;

  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetLock = true;
  bool isTrunkLock = true;

  bool isCoolingSelected = false;

  bool isShowingTires = false;

  final List<double> tyrePsi = [24.6, 34.5, 35, 34.8];

  int temperature = 24;

  void updateTemperature(int value) {
    temperature += value;
    logger.i('Current temperature: $temperature');
    notifyListeners();
  }

  void updateShowingTires() {
    isShowingTires = !isShowingTires;
    notifyListeners();
  }

  void updateCoolingSelected() {
    isCoolingSelected = !isCoolingSelected;
    logger.i('Cooling selected: $isCoolingSelected');
    notifyListeners();
  }

  void onNavigationTabChange(NavigationTab tab) {
    selectedNavigationTab = tab;
    logger.i('Change navigation tab: $selectedNavigationTab');
    notifyListeners();
  }

  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    logger.i('Right door lock: $isRightDoorLock');
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    logger.i('Left door lock: $isLeftDoorLock');
    notifyListeners();
  }

  void updateBonnetLock() {
    isBonnetLock = !isBonnetLock;
    logger.i('Bonnet door lock: $isBonnetLock');
    notifyListeners();
  }

  void updateTrunkLock() {
    isTrunkLock = !isTrunkLock;
    logger.i('Trunk door lock: $isTrunkLock');
    notifyListeners();
  }
}

enum NavigationTab {
  lock('lock.svg'),
  charge('charge.svg'),
  temperature('temperature.svg'),
  tyre('tyre.svg');

  const NavigationTab(this.assetName);

  final String assetName;
}
