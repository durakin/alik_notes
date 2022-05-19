import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
        const marker1 = Marker(
          markerId: MarkerId("ИКИТ"),
          position: LatLng(55.994446, 92.797586),
          infoWindow: InfoWindow(
            title: "ИКИТ",
            snippet: "Учебное заведение",
          ),
        );
      _markers["sibfu"] = marker1;
      const marker2 = Marker(
        markerId: MarkerId(""),
        position: LatLng(56.023636, 92.859636),
        infoWindow: InfoWindow(
          title: "Часовня Параскевы Пятницы",
          snippet: "Один из символов города Красноярска",
        ),
      );
      _markers["chapel"] = marker2;
    });
  }
  final LatLng _center = const LatLng(55.994446, 92.797586);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 18.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
