import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/custom_drawer/constants.dart';

typedef DrawerItemBuilder = Widget Function(
  BuildContext context,
  int index,
  bool isSelected,
);

class CustomDrawerController extends ChangeNotifier {
  CustomDrawerController({required this.pages, this.selectedIndex = 0})
      : selectedPage = pages[selectedIndex];

  final List<DrawerPage> pages;

  int selectedIndex;
  DrawerPage selectedPage;
  bool isExpanded = false;

  void updateIndex({required int index}) {
    selectedIndex = index;
    selectedPage = pages[selectedIndex];
    notifyListeners();
  }

  void updateDraver() {
    isExpanded = !isExpanded;
    notifyListeners();
  }
}

class DrawerPage {
  DrawerPage({
    required this.name,
    required this.body,
    this.leading,
  });

  final String name;
  final Widget? leading;
  final Widget body;
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.header,
    this.footer,
    this.colapsedDrawerSize = 0.02,
    this.expandedDrawerSize = 0.85,
    this.backgroundColor = drawerColor,
    this.drawerPadding = const EdgeInsets.all(defaultPadding),
    this.divider,
  });

  final CustomDrawerController controller;
  final DrawerItemBuilder itemBuilder;
  final Widget? header;
  final Widget? footer;
  final double colapsedDrawerSize;
  final double expandedDrawerSize;
  final Color backgroundColor;
  final EdgeInsets drawerPadding;
  final Widget? divider;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _iconAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  void updateDrawer() {
    widget.controller.updateDraver();
    widget.controller.isExpanded
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, snapshot) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: defaultDuration,
                height: size.height,
                width: size.width * widget.expandedDrawerSize,
                right: widget.controller.isExpanded
                    ? size.width * (1 - widget.expandedDrawerSize)
                    : size.width * (1 - widget.colapsedDrawerSize),
                child: Container(
                  padding: widget.drawerPadding,
                  color: widget.backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.header ?? const SizedBox.shrink(),
                      widget.divider ?? const SizedBox.shrink(),
                      for (var i = 0; i < widget.controller.pages.length; i++)
                        widget.itemBuilder(
                          context,
                          i,
                          widget.controller.selectedIndex == i,
                        ),
                      widget.divider ?? const SizedBox.shrink(),
                      widget.footer ?? const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                top: 0,
                bottom: 0,
                left: widget.controller.isExpanded
                    ? size.width * widget.expandedDrawerSize
                    : size.width * widget.colapsedDrawerSize,
                width: size.width - (size.width * widget.colapsedDrawerSize),
                duration: defaultDuration,
                child: widget.controller.selectedPage.body,
              ),
              AnimatedPositioned(
                top: size.height * 0.05,
                height: size.height * 0.14,
                width: size.width * 0.07,
                left: widget.controller.isExpanded
                    ? size.width * widget.expandedDrawerSize
                    : size.width * widget.colapsedDrawerSize,
                duration: defaultDuration,
                child: GestureDetector(
                  onTap: updateDrawer,
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: ColoredBox(
                      color: widget.backgroundColor,
                      child: Center(
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _iconAnimation,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        0,
        0,
        0,
        size.height,
        0,
        size.height,
      )
      ..cubicTo(
        0,
        size.height * 0.8,
        size.width,
        size.height * 0.8,
        size.width * 1,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width,
        size.height * 0.2,
        0,
        size.height * 0.2,
        0,
        0,
      )
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
