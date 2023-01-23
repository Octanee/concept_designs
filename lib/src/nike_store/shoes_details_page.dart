import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/nike_store/constants.dart';
import 'package:concept_designs/src/nike_store/shoes.dart';
import 'package:concept_designs/src/nike_store/shopping_cart.dart';
import 'package:ionicons/ionicons.dart';

class ShoesDetailsPage extends StatelessWidget {
  ShoesDetailsPage({super.key, required this.shoes});

  final Shoes shoes;

  final ValueNotifier<bool> bottomButtonsVisibleNotifier = ValueNotifier(false);

  Future<void> _openShoppingCart({required BuildContext context}) async {
    bottomButtonsVisibleNotifier.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        pageBuilder: (_, __, ___) => ShoppingCart(shoes: shoes),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
    bottomButtonsVisibleNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerSize = size.height / 2;
    final padding = headerSize * 0.05;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bottomButtonsVisibleNotifier.value = true;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'logo',
          child: Image.asset(
            getPath('nike_logo.png'),
            height: 48,
          ),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          //* ------------------------------
          //* Content
          //* ------------------------------
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //* ------------------------------
                //* Header
                //* ------------------------------
                SizedBox(
                  height: headerSize,
                  child: Stack(
                    children: [
                      //* ------------------------------
                      //* Background
                      //* ------------------------------
                      Positioned.fill(
                        child: Hero(
                          tag: 'background_${shoes.model}',
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(shoes.color),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //* ------------------------------
                      //* Model number
                      //* ------------------------------
                      Positioned(
                        left: padding,
                        right: padding,
                        height: headerSize * 0.6,
                        child: Hero(
                          tag: 'model_number_${shoes.model}',
                          child: Material(
                            color: Colors.transparent,
                            child: FittedBox(
                              child: Text(
                                shoes.modelNumber.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black.withOpacity(0.03),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //* ------------------------------
                      //* Carousel
                      //* ------------------------------
                      PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: shoes.images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Hero(
                              tag: 'image_${shoes.model}_$index',
                              child: Image.asset(
                                shoes.images[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                //* ------------------------------
                //* Details
                //* ------------------------------
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                    right: defaultPadding,
                    top: defaultPadding * 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* ------------------------------
                      //* Name and prices
                      //* ------------------------------
                      _ShakeTransition(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                shoes.model,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: defaultPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${shoes.oldPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding / 2),
                                Text(
                                  '\$${shoes.oldPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      //* ------------------------------
                      //* Sizes
                      //* ------------------------------
                      const SizedBox(height: defaultPadding * 3),
                      _ShakeTransition(
                        additionalDuration: defaultDuration,
                        child: Text(
                          'AVAILABLE SIZES',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      _ShakeTransition(
                        additionalDuration: defaultDuration * 2,
                        child: Row(
                          children: List.generate(
                            5,
                            (index) => _ShoesSize(text: 'US ${index + 6}'),
                          ),
                        ),
                      ),
                      //* ------------------------------
                      //* Description
                      //* ------------------------------
                      const SizedBox(height: defaultPadding * 3),
                      _ShakeTransition(
                        additionalDuration: defaultDuration * 3,
                        child: Text(
                          'DESCRIPTION',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //* ------------------------------
          //* Bottom buttons
          //* ------------------------------
          ValueListenableBuilder<bool>(
            valueListenable: bottomButtonsVisibleNotifier,
            builder: (context, isVisible, child) {
              return AnimatedPositioned(
                duration: defaultDuration,
                left: 0,
                right: 0,
                bottom: isVisible
                    ? 0
                    : -(kBottomNavigationBarHeight + defaultPadding),
                child: child!,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: 'heart_outline',
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: const Icon(
                      Ionicons.heart_outline,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    heroTag: 'bag_add_outline',
                    backgroundColor: Colors.black,
                    onPressed: () => _openShoppingCart(context: context),
                    child: const Icon(
                      Ionicons.bag_add_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShoesSize extends StatelessWidget {
  const _ShoesSize({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _ShakeTransition extends StatelessWidget {
  const _ShakeTransition({
    required this.child,
    this.additionalDuration = Duration.zero,
  });

  final Widget child;
  final Duration additionalDuration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: 0),
      duration: const Duration(milliseconds: 900) + additionalDuration,
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * 256, 0),
          child: child,
        );
      },
      child: child,
    );
  }
}
