import 'dart:convert';

import 'package:http/http.dart' as http;

class services {
  static Future<List> getData_predios(cp) async {
    List geometry_list = [];
    List demografic_data = [];
    List agebs = [];
    final data;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.http('192.168.100.82:3001', '/ageb/agebs_cp');
    var response =
        await http.post(url, headers: headers, body: json.encode({'cp': cp}));

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      for (var element in data) {
        geometry_list.add(element["geometry"]);
        agebs.add(element["idAgeb"]);
        Map map = {
          'f': element["numTotalFemenino"],
          'm': element["numTotalMasculino"],
          't': element["numTotalHabitantes"],
        };
        demografic_data.add(map);
      }

      return [agebs, geometry_list, demografic_data];
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<String> getPolygonBYageb_predios(ageb) async {
    final data;
    final data_res;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final url = Uri.http('192.168.100.82:3001', '/ageb/polygons_ageb');
    var response = await http.post(url,
        headers: headers, body: json.encode({'idAgeb': ageb}));

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      data_res = data[0]["geometry"];

      return data_res;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List> getMarkersbyCP_predios(cp) async {
    print("hola desde api markers bt CP");
    List markers_list = [];
    final data;
    final data_res;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final url = Uri.http('192.168.100.82:3001', '/ageb/markers_cp');
    var response =
        await http.post(url, headers: headers, body: json.encode({'cp': cp}));

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      // data_res = data[0]["geometry"];
      for (var element in data) {
        print("''''''''''''''''''''''''''''''''");
        print(element);
        markers_list.add(element);
      }

      return markers_list;
    } else {
      throw Exception('Failed to load post');
    }
  }

  //
  //
  //   static Future<List> getMarkersbyCP(CP) async {
  //   List markers_list = [];
  //   var result = await connector.execute(
  //     "select * from datos_prueba where codigoPostal= :CP",
  //     {'CP': CP},
  //   );

  //   for (final row in result.rows) {

  //     markers_list.add(row.assoc());
  //   }
  //   return markers_list;
  // }
}
