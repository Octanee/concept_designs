// ignore_for_file: lines_longer_than_80_chars

import 'package:concept_designs/src/travy/models/category.dart';
import 'package:concept_designs/src/travy/models/destination.dart';

class DestinationRepository {
  Future<List<Destination>> getDestinations() {
    return Future<List<Destination>>.delayed(
      const Duration(seconds: 1),
      () => _destinations,
    );
  }

  static List<Destination> get _destinations => <Destination>[
        ..._beachDestinations,
        ..._mountainsDestinations,
      ];

  static List<Destination> get _beachDestinations => <Destination>[
        Destination(
          name: 'Patong Beach',
          localization: 'Phuket, Thailand',
          description:
              'Patong Beach is located on the west coast of the island of Phuket, Thailand. It is a popular destination for tourists due to its beautiful white sand beach and crystal clear water. The beach is also known for its vibrant nightlife, with many bars, clubs, and restaurants located in the area. In addition to swimming and sunbathing, visitors can also participate in water sports such as jet skiing, parasailing, and snorkeling. There are also many shops and markets in the area where visitors can purchase souvenirs and local handicrafts. The beach is easily accessible from Phuket Town, which is about a 20 minute drive away.',
          imagePath: 'assets/travy/beach (1).jpg',
          category: DestinationCategory.beach,
          price: 47,
          score: 5,
        ),
        Destination(
          name: 'Bondi Beach',
          localization: 'Sydney, Australia',
          description: 'Description',
          imagePath: 'assets/travy/beach (2).jpg',
          category: DestinationCategory.beach,
          price: 47,
          score: 3,
        ),
        Destination(
          name: 'Copacabana Beach',
          localization: 'Rio de Janeiro, Brazil',
          description: 'Description',
          imagePath: 'assets/travy/beach (3).jpg',
          category: DestinationCategory.beach,
          price: 47,
          score: 5,
        ),
        Destination(
          name: 'Santa Monica Beach',
          localization: 'Los Angeles, California',
          description: 'Description',
          imagePath: 'assets/travy/beach (4).jpg',
          category: DestinationCategory.beach,
          price: 47,
          score: 3,
        ),
        Destination(
          name: 'Punta Cana',
          localization: 'Dominican Republic',
          description: 'Description',
          imagePath: 'assets/travy/beach (5).jpg',
          category: DestinationCategory.beach,
          price: 47,
        ),
        Destination(
          name: 'Waikiki Beach',
          localization: 'Oahu, Hawaii',
          description: 'Description',
          imagePath: 'assets/travy/beach (6).jpg',
          category: DestinationCategory.beach,
          price: 47,
        ),
      ];

  static List<Destination> get _mountainsDestinations => <Destination>[
        Destination(
          name: 'Patong Beach',
          localization: 'Phuket, Thailand',
          description:
              'Patong Beach is located on the west coast of the island of Phuket, Thailand. It is a popular destination for tourists due to its beautiful white sand beach and crystal clear water. The beach is also known for its vibrant nightlife, with many bars, clubs, and restaurants located in the area. In addition to swimming and sunbathing, visitors can also participate in water sports such as jet skiing, parasailing, and snorkeling. There are also many shops and markets in the area where visitors can purchase souvenirs and local handicrafts. The beach is easily accessible from Phuket Town, which is about a 20 minute drive away.',
          imagePath: 'assets/travy/mountains (1).jpg',
          category: DestinationCategory.mountains,
          price: 47,
          score: 5,
        ),
        Destination(
          name: 'Bondi Beach',
          localization: 'Sydney, Australia',
          description: 'Description',
          imagePath: 'assets/travy/mountains (2).jpg',
          category: DestinationCategory.mountains,
          price: 47,
          score: 3,
        ),
        Destination(
          name: 'Copacabana Beach',
          localization: 'Rio de Janeiro, Brazil',
          description: 'Description',
          imagePath: 'assets/travy/mountains (3).jpg',
          category: DestinationCategory.mountains,
          price: 47,
          score: 5,
        ),
        Destination(
          name: 'Santa Monica Beach',
          localization: 'Los Angeles, California',
          description: 'Description',
          imagePath: 'assets/travy/mountains (4).jpg',
          category: DestinationCategory.mountains,
          price: 47,
          score: 3,
        ),
        Destination(
          name: 'Punta Cana',
          localization: 'Dominican Republic',
          description: 'Description',
          imagePath: 'assets/travy/mountains (5).jpg',
          category: DestinationCategory.mountains,
          price: 47,
        ),
      ];
}
