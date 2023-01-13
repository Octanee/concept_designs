// ignore_for_file: lines_longer_than_80_chars

import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/fika_coffee/models/coffee.dart';
import 'package:concept_designs/src/fika_coffee/pages/coffee_details_page.dart';

const _initialPage = 8;

class CoffeeListPage extends StatefulWidget {
  const CoffeeListPage({super.key, required this.coffee});

  final List<Coffee> coffee;

  @override
  State<CoffeeListPage> createState() => _CoffeeListPageState();
}

class _CoffeeListPageState extends State<CoffeeListPage> {
  late PageController _pageCofeeController;
  late PageController _nameCofeeController;

  double _currentPage = _initialPage.toDouble();
  double _namePage = _initialPage.toDouble();

  @override
  void initState() {
    super.initState();
    _pageCofeeController = PageController(
      viewportFraction: 0.35,
      initialPage: _initialPage,
    )..addListener(_coffeScrollListener);

    _nameCofeeController = PageController(initialPage: _initialPage)
      ..addListener(_nameScrollListener);
  }

  @override
  void dispose() {
    _pageCofeeController
      ..removeListener(_coffeScrollListener)
      ..dispose();

    _nameCofeeController
      ..removeListener(_nameScrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: size.width * 0.035,
            right: size.width * 0.035,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: size.height * 0.1,
                    spreadRadius: size.height * 0.05,
                  )
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: _pageCofeeController,
              scrollDirection: Axis.vertical,
              onPageChanged: (value) {
                if (value < widget.coffee.length) {
                  _nameCofeeController.animateToPage(
                    value,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              },
              itemCount: widget.coffee.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final item = widget.coffee[index - 1];
                final result = _currentPage - index + 1;
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder<void>(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FadeTransition(
                          opacity: animation,
                          child: CoffeeDetailsPage(coffee: item),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.025),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                          0.0,
                          size.height / 2.6 * (1 - value).abs(),
                        )
                        ..scale(value),
                      child: Opacity(
                        opacity: opacity,
                        child: Hero(
                          tag: item.imagePath,
                          child: Image.asset(
                            item.imagePath,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: size.height * 0.1,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1, end: 0),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) => Transform.translate(
                offset: Offset(0, -100 * value),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _nameCofeeController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.coffee.length,
                        itemBuilder: (context, index) {
                          final opacity =
                              (1 - (index - _namePage).abs()).clamp(0.0, 1.0);
                          return Opacity(
                            opacity: opacity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1,
                              ),
                              child: Text(
                                widget.coffee[index].name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        '\$${widget.coffee[_currentPage.toInt()].price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 30),
                        key: Key(widget.coffee[_currentPage.toInt()].name),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _coffeScrollListener() {
    setState(() => _currentPage = _pageCofeeController.page!);
  }

  void _nameScrollListener() {
    setState(() => _namePage = _nameCofeeController.page!);
  }
}
