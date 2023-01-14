// ignore_for_file: lines_longer_than_80_chars

import 'package:concept_designs/src/common.dart';

class SuperHero {
  SuperHero({
    required this.name,
    required this.realName,
    required this.universe,
    required this.description,
    required this.imagePath,
    required this.color,
  });

  final String name;
  final String realName;
  final String universe;
  final String description;
  final String imagePath;
  final Color color;
}

final superHeroes = <SuperHero>[
  SuperHero(
    name: 'Iron Man',
    realName: 'Tony Stark',
    universe: 'Marvel',
    description:
        'Iron Man is a superhero appearing in American comic books published by Marvel Comics. The character was co-created by writer-editor Stan Lee and designed by artist Don Heck and first appeared in Tales of Suspense #39 (cover dated March 1963). The character is the alter ego of Tony Stark, a wealthy American playboy, genius inventor, and ingenious engineer who uses a powered suit of armor to protect the world as Iron Man. The suit is technologically advanced and gives Stark superhuman strength, flight, and various other abilities. Iron Man has appeared in several comic book series and adaptations, including animated television series, video games and films. The Marvel Cinematic Universe (MCU) includes several films in which Iron Man is a central character, played by actor Robert Downey Jr.',
    imagePath: 'assets/super_hero/iron_man.png',
    color: const Color(0xFFEE6F38),
  ),
  SuperHero(
    name: 'Iron Man',
    realName: 'Tony Stark',
    universe: 'Marvel',
    description:
        'Iron Man is a superhero appearing in American comic books published by Marvel Comics. The character was co-created by writer-editor Stan Lee and designed by artist Don Heck and first appeared in Tales of Suspense #39 (cover dated March 1963). The character is the alter ego of Tony Stark, a wealthy American playboy, genius inventor, and ingenious engineer who uses a powered suit of armor to protect the world as Iron Man. The suit is technologically advanced and gives Stark superhuman strength, flight, and various other abilities. Iron Man has appeared in several comic book series and adaptations, including animated television series, video games and films. The Marvel Cinematic Universe (MCU) includes several films in which Iron Man is a central character, played by actor Robert Downey Jr.',
    imagePath: 'assets/super_hero/iron_man.png',
    color: const Color.fromARGB(255, 124, 167, 9),
  ),
];
