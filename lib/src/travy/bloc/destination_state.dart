part of 'destination_bloc.dart';

enum DestinationStatus {
  initial,
  loading,
  loaded,
  failure,
}

class DestinationState extends Equatable {
  const DestinationState({
    this.status = DestinationStatus.initial,
    this.category = DestinationCategory.beach,
    this.destinations = const [],
  });

  final DestinationStatus status;
  final DestinationCategory category;
  final List<Destination> destinations;

  List<Destination> popularDestinations() {
    final data = destinations
        .where((destination) => destination.category == category)
        .toList()
      ..sort(
        (a, b) => b.score.compareTo(a.score),
      );

    return data.take(5).toList();
  }

  List<Destination> nerbyDestinations() {
    final data = destinations
        .where((destination) => destination.category == category)
        .toList()
      ..shuffle();

    return data.take(5).toList();
  }

  @override
  String toString() {
    final data = {
      'status': status,
      'category': category,
      'destinations': destinations.length,
    };

    return 'DestinationState: $data';
  }

  @override
  List<Object> get props => [status, category, destinations];

  DestinationState copyWith({
    DestinationStatus? status,
    DestinationCategory? category,
    List<Destination>? destinations,
  }) {
    return DestinationState(
      status: status ?? this.status,
      category: category ?? this.category,
      destinations: destinations ?? this.destinations,
    );
  }
}
