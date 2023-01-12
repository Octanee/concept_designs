import 'package:concept_designs/src/common.dart';

class HorizontalScrollView extends StatelessWidget {
  const HorizontalScrollView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.separatorSize = 8,
  });

  final int itemCount;
  final double separatorSize;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(
        children: List.generate(
          itemCount,
          (index) => Padding(
            padding: index != itemCount - 1
                ? EdgeInsets.only(right: separatorSize)
                : EdgeInsets.zero,
            child: itemBuilder(context, index),
          ),
        ),
      ),
    );
  }
}
