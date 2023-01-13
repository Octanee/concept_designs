import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/fika_coffee/models/coffee.dart';

class CoffeeRepository {
  Future<List<Coffee>> getCoffee() {
    return Future<List<Coffee>>.delayed(
      const Duration(seconds: 1),
      () => _coffee,
    );
  }

  static final List<Coffee> _coffee = List.generate(
    _coffeeNames.length,
    (index) => Coffee(
      name: _coffeeNames[index],
      imagePath: 'assets/fika_coffee/${index + 1}.png',
      price: doubleFromRange(min: 3, max: 7),
    ),
  );

  static final List<String> _coffeeNames = [
    'Caramel Macchiato',
    'Caramel Cold Drink',
    'Iced Coffe Mocha',
    'Caramelized Pecan Latte',
    'Toffee Nut Latte',
    'Capuchino',
    'Toffee Nut Iced Latte',
    'Americano',
    'Vietnamese-Style Iced Coffee',
    'Black Tea Latte',
    'Classic Irish Coffee',
    'Toffee Nut Crunch Latte',
  ];
}
