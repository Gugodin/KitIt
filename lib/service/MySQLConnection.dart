import 'package:mysql_client/mysql_client.dart';

class MySQLConnector {
  static final connector = MySQLConnectionPool(
      host: "173.201.188.200",
      port: 3306,
      userName: "dbUKikitLocales",
      password: "[D^JosvIrT{u",
      databaseName: "KIKIT_locales", // optional
      maxConnections: 100);

  static Future<List> getData(CP) async {
    List geometry_list = [];
    List demografic_data = [];
    List agebs = [];
    print('____________________________________CODIGO POSTAL ${CP}');
    var result = await connector.execute(
        // "SELECT * FROM agebs where region=5 ",
        "select * from agebs  where agebs.codigoPostal= :CP",
        {'CP': CP});

    print('______RESULTADOS_______');

    for (final row in result.rows) {
      // print(row.assoc());

      geometry_list.add([row.assoc()["geometry"]]);
      agebs.add(row.assoc()["idAgeb"]);
      // row.assoc()["numTotalFemenino"],
      //   row.assoc()["numTotalMasculino"],
      //   row.assoc()["numTotalHabitantes"]

      Map map = {
        'f': row.assoc()["numTotalFemenino"],
        'm': row.assoc()["numTotalMasculino"],
        't': row.assoc()["numTotalHabitantes"],
      };
      demografic_data.add(map);
    }
    // print(agebs);
    // print(demografic_data);
    return [agebs, geometry_list, demografic_data];
  }

  static Future<List> getPolygonBYageb(ageb) async {
    List geometry_list = [];
    var result = await connector.execute(
        // "SELECT * FROM agebs where region=5 ",
        "select * from agebs  where agebs.idAgeb= :idAgeb",
        {'idAgeb': ageb});

    for (final row in result.rows) {
      // print(row.assoc());

      geometry_list.add([row.assoc()["geometry"]]);
    }
    return geometry_list;
  }

  static Future<List> getMarkersbyCP(CP) async {
    List markers_list = [];
    var result = await connector.execute(
      "select * from comercios where codigoPostal= :CP",
      {'CP': CP},
    );
    for (final row in result.rows) {
      markers_list.add(row.assoc());
    }
    return markers_list;
  }

  static Future<List> getDemograficData() async {
    List markers_list = [];
    var result = await connector.execute("select * from demograficos");
    for (final row in result.rows) {
      markers_list.add(row.assoc());
    }
    // print('JALO?');
    // print(markers_list);
    return markers_list;
  }

  static Future<List> getSecurityByColonia(String colonia) async {
    List markers_list = [];
    var result = await connector.execute(
        "SELECT delito,cantidad FROM delitos where colonia=:COLONIA",
        {'COLONIA': colonia});
    for (final row in result.rows) {
      markers_list.add(row.assoc());
    }
    print('JALO?');
    print(markers_list);
    return markers_list;
  }
}
