import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:concept_designs/src/fika_coffee/data/coffee_repository.dart';
import 'package:concept_designs/src/fika_coffee/models/coffee.dart';
import 'package:equatable/equatable.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  CoffeeBloc({required CoffeeRepository coffeeRepository})
      : _coffeeRepository = coffeeRepository,
        super(const CoffeeState()) {
    on<CoffeeLoading>(_onCoffeeLoading);
  }

  final CoffeeRepository _coffeeRepository;

  FutureOr<void> _onCoffeeLoading(
    CoffeeLoading event,
    Emitter<CoffeeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CoffeeStatus.loading));

      final data = await _coffeeRepository.getCoffee();

      emit(
        state.copyWith(status: CoffeeStatus.loaded, coffee: data),
      );
    } catch (e) {
      emit(state.copyWith(status: CoffeeStatus.failure));
    }
  }
}
