import 'dart:ui';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../service/MySQLConnection.dart';

class MarkersCom {
  Set<Marker> _markersComers = new Set();
  List data_markers = [];

  MarkersCom(List data_markers) {
    this.data_markers = data_markers;
  }

  Set<Marker> printMarkersComers(
      CustomInfoWindowController _customInfoWindowController) {
    List LonLat_markers = [];

    for (var i = 0; i < data_markers.length; i++) {
      String cord_aux = data_markers[i]["coordenadas"].replaceAll(" ", "");

      List cord_list = cord_aux.split(",");
      // print(cord_list);

      Marker markerNew = Marker(
        markerId: MarkerId("${i}"),
        consumeTapEvents: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(
          double.parse(cord_list[0]),
          double.parse(cord_list[1]),
        ),
        zIndex: 2,
        anchor: const Offset(0.5, 1),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              color: Color(0xFFFF9000),
             
              child: Text(
                data_markers[i]["nombre"],
              ),
            ),
            LatLng(double.parse(cord_list[0]), double.parse(cord_list[1])),
          );
        },
      );
      _markersComers.add(markerNew);
    }
    return _markersComers;
  }
}
