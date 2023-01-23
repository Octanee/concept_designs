import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/nike_store/constants.dart';
import 'package:concept_designs/src/nike_store/shoes.dart';
import 'package:concept_designs/src/nike_store/shoes_details_page.dart';
import 'package:ionicons/ionicons.dart';

class NikeStorePage extends StatelessWidget {
  NikeStorePage({super.key});

  final ValueNotifier<bool> bottomBarVisibleNotifier = ValueNotifier(true);

  Future<void> _onShoesTap({
    required BuildContext context,
    required Shoes item,
  }) async {
    bottomBarVisibleNotifier.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => ShoesDetailsPage(shoes: item),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
    bottomBarVisibleNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
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
        leading: Container(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            //* ------------------------------
            //* Content
            //* ------------------------------
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //* ------------------------------
                  //* Shoes
                  //* ------------------------------
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                        right: defaultPadding,
                        bottom: defaultPadding + kBottomNavigationBarHeight,
                      ),
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: defaultPadding),
                      itemCount: shoes.length,
                      itemBuilder: (context, index) {
                        final item = shoes[index];
                        return _ShoesItem(
                          shoes: item,
                          onTap: () => _onShoesTap(
                            context: context,
                            item: item,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            //* ------------------------------
            //* Bottom bar
            //* ------------------------------
            ValueListenableBuilder<bool>(
              valueListenable: bottomBarVisibleNotifier,
              builder: (context, isVisible, child) {
                return AnimatedPositioned(
                  duration: defaultDuration,
                  left: 0,
                  right: 0,
                  bottom: isVisible ? 0 : -kBottomNavigationBarHeight,
                  height: kBottomNavigationBarHeight,
                  child: child!,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                color: Colors.white.withOpacity(0.9),
                child: Row(
                  children: [
                    const Expanded(
                      child: Icon(Ionicons.home_outline),
                    ),
                    const Expanded(
                      child: Icon(Ionicons.search_outline),
                    ),
                    const Expanded(
                      child: Icon(Ionicons.heart_outline),
                    ),
                    const Expanded(
                      child: Icon(Ionicons.bag_outline),
                    ),
                    Expanded(
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          getPath('women.jpg'),
                        ),
                        radius: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShoesItem extends StatelessWidget {
  const _ShoesItem({
    required this.shoes,
    required this.onTap,
  });

  final Shoes shoes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final itemSize = MediaQuery.of(context).size.width;
    final padding = itemSize * 0.05;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: itemSize,
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
                    borderRadius: BorderRadius.circular(16),
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
              height: itemSize * 0.6,
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
            //* Image
            //* ------------------------------
            Positioned(
              top: padding,
              left: padding,
              right: 0,
              height: itemSize * 0.6,
              child: Hero(
                tag: 'image_${shoes.model}_0',
                child: Image.asset(
                  shoes.images.first,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            //* ------------------------------
            //* Buttons
            //* ------------------------------
            Positioned(
              left: padding,
              bottom: padding,
              child: IconButton(
                icon: Icon(
                  Ionicons.heart_outline,
                  size: 32,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: padding,
              bottom: padding,
              child: IconButton(
                icon: Icon(
                  Ionicons.bag_add_outline,
                  size: 32,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {},
              ),
            ),
            //* ------------------------------
            //* Texts
            //* ------------------------------
            Positioned(
              left: 0,
              right: 0,
              bottom: padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    shoes.model,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
