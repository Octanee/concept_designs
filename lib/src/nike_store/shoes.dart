import 'package:concept_designs/src/nike_store/constants.dart';

class Shoes {
  Shoes({
    required this.model,
    required this.oldPrice,
    required this.currentPrice,
    required this.images,
    required this.modelNumber,
    this.color = 0xFFFFFF,
  });

  final String model;
  final double oldPrice;
  final double currentPrice;
  final List<String> images;
  final int modelNumber;
  final int color;
}

final shoes = <Shoes>[
  Shoes(
    model: 'AIR MAX 90 "EZ Black"',
    currentPrice: 149,
    oldPrice: 299,
    modelNumber: 90,
    images: [
      getPath('shoes1_1.png'),
      getPath('shoes1_2.png'),
      getPath('shoes1_3.png'),
    ],
    color: 0xFFF1F1F1,
  ),
  Shoes(
    model: 'AIR MAX 270 "Gold"',
    currentPrice: 199,
    oldPrice: 349,
    modelNumber: 270,
    images: [
      getPath('shoes2_1.png'),
      getPath('shoes2_2.png'),
      getPath('shoes2_3.png'),
    ],
    color: 0xFFFCF5EB,
  ),
  Shoes(
    model: 'AIR MAX 95 "Red"',
    currentPrice: 299,
    oldPrice: 399,
    modelNumber: 95,
    images: [
      getPath('shoes3_1.png'),
      getPath('shoes3_2.png'),
      getPath('shoes3_3.png'),
    ],
    color: 0xFFFEEFEF,
  ),
  Shoes(
    model: 'AIR MAX 98 "Free"',
    currentPrice: 149,
    oldPrice: 299,
    modelNumber: 98,
    images: [
      getPath('shoes4_1.png'),
      getPath('shoes4_2.png'),
      getPath('shoes4_3.png'),
    ],
    color: 0xFFEDF3FE,
  ),
];
