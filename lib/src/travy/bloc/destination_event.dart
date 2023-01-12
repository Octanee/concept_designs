part of 'destination_bloc.dart';

abstract class DestinationEvent extends Equatable {
  const DestinationEvent();

  @override
  List<Object> get props => [];
}

class DestinationLoading extends DestinationEvent {
  const DestinationLoading();
}

class DestinationCategoryChange extends DestinationEvent {
  const DestinationCategoryChange({required this.category});

  final DestinationCategory category;

  @override
  List<Object> get props => [category];
}
