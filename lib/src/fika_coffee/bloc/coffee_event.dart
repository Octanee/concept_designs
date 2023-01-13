part of 'coffee_bloc.dart';

abstract class CoffeeEvent extends Equatable {
  const CoffeeEvent();

  @override
  List<Object> get props => [];
}

class CoffeeLoading extends CoffeeEvent {
  const CoffeeLoading();
}
