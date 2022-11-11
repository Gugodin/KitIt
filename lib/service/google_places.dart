import 'dart:convert';
import 'package:http/http.dart' as http;

class GooglePlace {
  static Future get_places_all(
      String tipoLugar, String latitud, String longitud) async {
   List<Map> negocios = [];

    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=${tipoLugar}&location=${latitud}%2C${longitud}&radius=1500&key=AIzaSyBW-I02qm2e2fhlbJg1mtL7bKG5ItJPB5A&language=es-419'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      try {
        for (var i = 0; i < data["results"].length; i++) {
          print("¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨");
          print(data["results"][i]["business_status"]);
          print(data["results"][i]["geometry"]["location"]);
          print(data["results"][i]["name"]);
          print(data["results"][i]["vicinity"]);
        }
      } catch (e) {
        print(e);
      }

      for (var element in data["results"]) {
        negocios.add({
          'lat': element["geometry"]["location"]["lat"],
          'lon': element["geometry"]["location"]["lng"],
          'nombre': element["name"],
          'direccion': element["vicinity"]
        });
      }
      return negocios;

      // return data;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
