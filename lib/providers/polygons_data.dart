import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class polygonsData with ChangeNotifier {
  Set<Polygon> _listaPolygons = new Set();

  get listaPolygons {
    return _listaPolygons;
  }

  set listaPolygons(poligonos) {
    this._listaPolygons = poligonos;

    notifyListeners();
  }
}
