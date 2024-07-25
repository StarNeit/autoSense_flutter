import 'package:flutter/material.dart';
import '../../models/station.dart';

class StationList extends StatelessWidget {
  final List<Station> stations;
  final Function(Station) onStationTap;

  const StationList(
      {Key? key, required this.stations, required this.onStationTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return GestureDetector(
            onTap: () => onStationTap(station),
            child: Card(
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.local_gas_station,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    station.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
