import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/station_bloc.dart';
import '../blocs/station_event.dart';
import '../blocs/station_state.dart';
import '../models/station.dart';
import '../networking/station_repository.dart';
import 'widgets/station_list.dart';
import 'widgets/station_map.dart';
import 'widgets/station_modal.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StationBloc _stationBloc;

  @override
  void initState() {
    super.initState();
    final stationRepository = RepositoryProvider.of<StationRepository>(context);
    _stationBloc = StationBloc(stationRepository)..add(LoadStations());
  }

  @override
  void dispose() {
    _stationBloc.close();
    super.dispose();
  }

  void _onStationSelected(Station station) {
    _stationBloc.add(SelectStation(station));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow modal to be full height if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: _stationBloc,
          child: BlocBuilder<StationBloc, StationState>(
            builder: (context, state) {
              if (state is StationLoaded && state.selectedStation != null) {
                return StationModal(
                  station: state.selectedStation!,
                  onSave: (station) {
                    _stationBloc.add(UpdateStation(station));
                  },
                  onEdit: (station) {
                    Navigator.of(context).pop(); // close current modal
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.0)),
                      ),
                      builder: (BuildContext context) {
                        return StationModal(
                          station: station,
                          isEditing: true,
                          onSave: (station) {
                            _stationBloc.add(UpdateStation(station));
                          },
                        );
                      },
                    );
                  },
                  onDelete: (station) {
                    _stationBloc.add(DeleteStation(station.id));
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }

  void _onAddStation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return StationModal(
          station: null,
          isEditing: true,
          onSave: (station) => _stationBloc.add(AddStation(station)),
        );
      },
    );
  }

  void _showActionSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Finder'),
      ),
      body: BlocProvider(
        create: (context) => _stationBloc,
        child: BlocConsumer<StationBloc, StationState>(
          listener: (context, state) {
            if (state is StationSuccess) {
              _showActionSnackbar(context, state.message);
              _stationBloc.add(LoadStations()); // Reload stations after success
            } else if (state is StationError) {
              _showActionSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is StationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StationLoaded) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: StationMap(
                          stations: state.stations,
                          onStationSelected: _onStationSelected,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: StationList(
                      stations: state.stations,
                      onStationTap: _onStationSelected,
                    ),
                  ),
                ],
              );
            } else if (state is StationError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddStation,
        child: const Icon(Icons.add),
      ),
    );
  }
}
