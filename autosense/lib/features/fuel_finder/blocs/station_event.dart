import 'package:equatable/equatable.dart';
import '../models/station.dart';

abstract class StationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStations extends StationEvent {}

class UpdateStation extends StationEvent {
  final Station station;

  UpdateStation(this.station);

  @override
  List<Object> get props => [station];
}

class AddStation extends StationEvent {
  final Station station;

  AddStation(this.station);

  @override
  List<Object> get props => [station];
}

class DeleteStation extends StationEvent {
  final String id;

  DeleteStation(this.id);

  @override
  List<Object> get props => [id];
}

class SelectStation extends StationEvent {
  final Station station;

  SelectStation(this.station);

  @override
  List<Object> get props => [station];
}
