import 'package:equatable/equatable.dart';
import '../models/station.dart';

abstract class StationState extends Equatable {
  @override
  List<Object> get props => [];
}

class StationInitial extends StationState {}

class StationLoading extends StationState {}

class StationLoaded extends StationState {
  final List<Station> stations;
  final Station? selectedStation;

  StationLoaded(this.stations, [this.selectedStation]);

  @override
  List<Object> get props => [stations, selectedStation ?? ''];
}

class StationSuccess extends StationState {
  final String message;

  StationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class StationError extends StationState {
  final String message;

  StationError(this.message);

  @override
  List<Object> get props => [message];
}
