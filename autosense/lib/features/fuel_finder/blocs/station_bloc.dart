import 'package:flutter_bloc/flutter_bloc.dart';
import '../networking/station_repository.dart';
import 'station_event.dart';
import 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  final StationRepository stationRepository;

  StationBloc(this.stationRepository) : super(StationInitial()) {
    on<LoadStations>(_onLoadStations);
    on<UpdateStation>(_onUpdateStation);
    on<AddStation>(_onAddStation);
    on<DeleteStation>(_onDeleteStation);
    on<SelectStation>(_onSelectStation);
  }

  void _onLoadStations(LoadStations event, Emitter<StationState> emit) async {
    emit(StationLoading());
    try {
      final stations = await stationRepository.fetchStations();
      emit(StationLoaded(stations));
    } catch (e) {
      emit(StationError('Failed to load stations: ${e.toString()}'));
    }
  }

  void _onUpdateStation(UpdateStation event, Emitter<StationState> emit) async {
    try {
      await stationRepository.updateStation(event.station);
      final stations = await stationRepository.fetchStations();
      emit(StationLoaded(stations));
      emit(StationSuccess('Station updated successfully'));
    } catch (e) {
      emit(StationError('Failed to update station: ${e.toString()}'));
    }
  }

  void _onAddStation(AddStation event, Emitter<StationState> emit) async {
    try {
      await stationRepository.addStation(event.station);
      final stations = await stationRepository.fetchStations();
      emit(StationLoaded(stations));
      emit(StationSuccess('Station added successfully'));
    } catch (e) {
      emit(StationError('Failed to add station: ${e.toString()}'));
    }
  }

  void _onDeleteStation(DeleteStation event, Emitter<StationState> emit) async {
    try {
      await stationRepository.deleteStation(event.id);
      final stations = await stationRepository.fetchStations();
      emit(StationLoaded(stations));
      emit(StationSuccess('Station deleted successfully'));
    } catch (e) {
      emit(StationError('Failed to delete station: ${e.toString()}'));
    }
  }

  void _onSelectStation(SelectStation event, Emitter<StationState> emit) async {
    final currentState = state;
    if (currentState is StationLoaded) {
      emit(StationLoaded(currentState.stations, event.station));
    }
  }
}
