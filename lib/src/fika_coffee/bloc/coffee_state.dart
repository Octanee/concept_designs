part of 'coffee_bloc.dart';

enum CoffeeStatus {
  initial,
  loading,
  loaded,
  failure,
}

class CoffeeState extends Equatable {
  const CoffeeState({
    this.status = CoffeeStatus.initial,
    this.coffee = const [],
  });

  final CoffeeStatus status;
  final List<Coffee> coffee;

  @override
  List<Object> get props => [status, coffee];

  @override
  String toString() {
    final data = {
      'status': status,
      'coffee': coffee.length,
    };

    return 'CoffeeState: $data';
  }

  CoffeeState copyWith({
    CoffeeStatus? status,
    List<Coffee>? coffee,
  }) {
    return CoffeeState(
      status: status ?? this.status,
      coffee: coffee ?? this.coffee,
    );
  }
}
