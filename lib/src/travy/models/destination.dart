import 'package:concept_designs/src/travy/models/category.dart';

class Destination {
  Destination({
    required this.name,
    required this.localization,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    this.score = 4,
    this.isFavorit = false,
  });

  final String name;
  final String localization;
  final String description;

  final double score;
  final double price;

  final DestinationCategory category;

  final String imagePath;
  final bool isFavorit;
}
