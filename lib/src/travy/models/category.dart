enum DestinationCategory {
  beach(name: 'Beach', path: 'assets/travy/parasol.png'),
  mountains(name: 'Mountains', path: 'assets/travy/mountain.png'),
  river(name: 'River', path: 'assets/travy/river.png'),
  camping(name: 'Camping', path: 'assets/travy/tent.png');

  const DestinationCategory({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}
