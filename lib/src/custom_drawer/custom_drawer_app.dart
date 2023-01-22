import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/custom_drawer/custom_drawer.dart';

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
        itemBuilder: (context, index, isSelected) =>
            Text('Page build $index $isSelected'),
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
