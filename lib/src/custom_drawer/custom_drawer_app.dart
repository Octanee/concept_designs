import 'package:concept_designs/src/animated_login/constants.dart';
import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/custom_drawer/custom_drawer.dart';
import 'package:ionicons/ionicons.dart';

class CustomDrawerApp extends StatelessWidget {
  CustomDrawerApp({super.key});

  final _controller = CustomDrawerController(
    pages: List.generate(
      5,
      (index) => DrawerPage(
        name: 'Page $index',
        body: ColoredBox(color: _colors[index]),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: CustomDrawer(
        controller: _controller,
        header: const Text('Header'),
        divider: const Divider(
          color: Colors.grey,
          height: defaultPadding * 2,
        ),
        itemBuilder: (context, index, isSelected) => DrawerItem(
          leading: Icon(_icons[index]),
          title: Text('Page $index'),
        ),
      ),
    );
  }
}

final _colors = [
  Colors.grey,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.red
];

final _icons = [
  Ionicons.home_outline,
  Ionicons.list_outline,
  Ionicons.contract_outline,
  Ionicons.add_outline,
  Ionicons.settings_outline,
];
