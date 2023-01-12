import 'package:concept_designs/src/common.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  const ScrollToHideWidget({
    super.key,
    required this.controller,
    required this.child,
    this.height = kBottomNavigationBarHeight,
    this.duration = const Duration(milliseconds: 300),
  });

  final ScrollController controller;
  final Widget child;
  final Duration duration;
  final double height;

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? widget.height : 0,
      child: widget.child,
    );
  }

  void _listen() {
    final direction = widget.controller.position.userScrollDirection;
    switch (direction) {
      case ScrollDirection.idle:
        break;
      case ScrollDirection.forward:
        _show();
        break;
      case ScrollDirection.reverse:
        _hide();
        break;
    }
  }

  void _show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void _hide() {
    if (isVisible) setState(() => isVisible = false);
  }
}
