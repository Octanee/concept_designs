import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:concept_designs/src/travy/data/destination_repository.dart';
import 'package:concept_designs/src/travy/models/category.dart';
import 'package:concept_designs/src/travy/models/destination.dart';
import 'package:equatable/equatable.dart';

part 'destination_event.dart';
part 'destination_state.dart';

class DestinationBloc extends Bloc<DestinationEvent, DestinationState> {
  DestinationBloc({required DestinationRepository destinationRepository})
      : _destinationRepository = destinationRepository,
        super(const DestinationState()) {
    on<DestinationLoading>(_onLoading);
    on<DestinationCategoryChange>(_onCategoryChange);
  }

  final DestinationRepository _destinationRepository;

  Future<void> _onLoading(
    DestinationLoading event,
    Emitter<DestinationState> emit,
  ) async {
    try {
      emit(state.copyWith(status: DestinationStatus.loading));

      final data = await _destinationRepository.getDestinations();

      emit(
        state.copyWith(status: DestinationStatus.loaded, destinations: data),
      );
    } catch (e) {
      emit(state.copyWith(status: DestinationStatus.failure));
    }
  }

  void _onCategoryChange(
    DestinationCategoryChange event,
    Emitter<DestinationState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }
}
