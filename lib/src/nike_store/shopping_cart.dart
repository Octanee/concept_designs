import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/nike_store/constants.dart';
import 'package:concept_designs/src/nike_store/shoes.dart';
import 'package:ionicons/ionicons.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key, required this.shoes});

  final Shoes shoes;

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _resizePanelAnimation;
  late Animation<double> _resizeButtonAnimation;
  late Animation<double> _addToCardAnimation;
  late Animation<double> _moveOutAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );
    _resizePanelAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          0.25,
          curve: Curves.easeIn,
        ),
      ),
    );
    _resizeButtonAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          0.25,
          curve: Curves.ease,
        ),
      ),
    );
    _addToCardAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.35,
          0.65,
          curve: Curves.easeInQuint,
        ),
      ),
    );
    _moveOutAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.7,
          0.9,
          curve: Curves.elasticIn,
        ),
      ),
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const buttonCircularSize = 60.0;
    final panelHeight = size.height * 0.6;

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final buttonWidth = (size.width / 2 * _resizeButtonAnimation.value)
              .clamp(buttonCircularSize, size.width / 2);

          final panelWidth = (size.width * _resizePanelAnimation.value)
              .clamp(buttonCircularSize, size.width);

          return Stack(
            children: [
              //* ------------------------------
              //* Background
              //* ------------------------------
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              //* ------------------------------
              //* Panel
              //* ------------------------------
              Positioned(
                bottom: (-defaultPadding - buttonCircularSize) *
                    _moveOutAnimation.value,
                left: 0,
                right: 0,
                height: panelHeight,
                child: OpenCartAnimation(
                  child: Stack(
                    children: [
                      //* ------------------------------
                      //* Panel background
                      //* ------------------------------
                      Positioned(
                        top: (panelHeight -
                                buttonCircularSize -
                                defaultPadding) *
                            _addToCardAnimation.value,
                        left: size.width / 2 - panelWidth / 2,
                        height: (panelHeight * _resizePanelAnimation.value)
                            .clamp(buttonCircularSize, panelHeight),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                defaultPadding * _resizePanelAnimation.value,
                          ),
                          width: panelWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                16 + (16 * (1 - _resizePanelAnimation.value)),
                              ),
                              bottom: Radius.circular(
                                32 * (1 - _resizePanelAnimation.value),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //* ------------------------------
                              //* Image and price
                              //* ------------------------------
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top:
                                          4 * (1 - _resizePanelAnimation.value),
                                    ),
                                    child: Image.asset(
                                      widget.shoes.images.first,
                                      height: ((panelWidth * 0.5) *
                                              _resizePanelAnimation.value)
                                          .clamp(50, size.height * 0.2)
                                          .toDouble(),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  if (_resizePanelAnimation.value == 1) ...[
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          widget.shoes.model,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          // ignore: lines_longer_than_80_chars
                                          '\$${widget.shoes.oldPrice.toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                              //* ------------------------------
                              //* Sizes
                              //* ------------------------------
                              if (_resizePanelAnimation.value == 1) ...[
                                const Divider(),
                                const SizedBox(height: defaultPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      getPath('feet.png'),
                                      height: panelHeight * 0.05,
                                    ),
                                    const SizedBox(width: defaultPadding),
                                    Text(
                                      'SELECT SIZE',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ]
                            ],
                          ),
                        ),
                      ),

                      //* ------------------------------
                      //* Add to card button
                      //* ------------------------------
                      Positioned(
                        left: (size.width / 2) - (buttonWidth / 2),
                        bottom: defaultPadding,
                        height: buttonCircularSize,
                        child: InkWell(
                          onTap: () => _controller.forward(),
                          child: Container(
                            width: buttonWidth,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Ionicons.bag_add_outline,
                                    color: Colors.white,
                                  ),
                                  if (_resizeButtonAnimation.value == 1) ...[
                                    const SizedBox(width: defaultPadding),
                                    const Text(
                                      'ADD TO CART',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class OpenCartAnimation extends StatelessWidget {
  const OpenCartAnimation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: 0),
      duration: defaultDuration,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value * size.height * 0.6),
          child: child,
        );
      },
      child: child,
    );
  }
}
