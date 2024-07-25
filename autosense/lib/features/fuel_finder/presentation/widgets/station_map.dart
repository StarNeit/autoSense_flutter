import 'dart:async';

import 'package:autosense/config/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/station.dart';

class StationMap extends StatefulWidget {
  final List<Station> stations;
  final Function(Station) onStationSelected;

  const StationMap(
      {Key? key, required this.stations, required this.onStationSelected})
      : super(key: key);

  @override
  _StationMapState createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  late BitmapDescriptor customIcon;

  @override
  void initState() {
    super.initState();
    getCustomIcon();
  }

  void getCustomIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        PngAssets.gasStationMarker);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.stations.first.latitude, widget.stations.first.longitude),
          zoom: 10,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers = widget.stations
                .map((station) => Marker(
                      markerId: MarkerId(station.id),
                      position: LatLng(station.latitude, station.longitude),
                      icon: customIcon,
                      onTap: () => widget.onStationSelected(station),
                    ))
                .toSet();
          });
        });
  }
}
