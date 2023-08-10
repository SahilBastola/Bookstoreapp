import 'package:ebuy/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});
  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  GoogleMapController? mapCOntroller;
  Set<Marker> markers = {};
  LatLng mylocation = const LatLng(27.7061102, 85.329979);

  @override
  void initState() {
    markers.add(Marker(
        markerId: MarkerId(
          mylocation.toString(),
        ),
        position: mylocation,
        infoWindow: const InfoWindow(title: 'Ebuy', snippet: 'Ebuy'),
        icon: BitmapDescriptor.defaultMarker));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orangeColors,
      body: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition: CameraPosition(target: mylocation, zoom: 10),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: ((controller) {
          setState(() {
            mapCOntroller = controller;
          });
        }),
      ),
    );
  }
}
