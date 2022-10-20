import 'dart:convert';
import 'package:http/http.dart' as http;

class datosDenue {
  static Future<List> fetchPost(
      tipoComercio, String latitud, String longitud) async {
    var response = await http.get(Uri.parse(
        'https://www.inegi.org.mx/app/api/denue/v1/consulta/Buscar/${tipoComercio}/${latitud},${longitud}/1000/d28a2536-ca8d-47da-bfac-6a57d5c396e0'));

    if (response.statusCode == 200) {
      List negocios = [];
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      var data = json.decode(response.body);
      for (var element in data) {
        // print(element);

        negocios
            .add([element["Latitud"], element["Longitud"], element["Nombre"]]);
      }
      return negocios;
    } else {
      // Si esta respuesta no fue OK, lanza un error.
      throw Exception('Failed to load post');
    }
  }
}
