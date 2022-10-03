import 'package:mysql1/mysql1.dart';

class MySQLConnector {
  static final ConnectionSettings _settings = ConnectionSettings(
      host: '192.168.100.247',
      port: 3306,
      user: 'kikit2',
      password: 'polloasado1',
      db: 'kikit');

  static late MySqlConnection connector;

  MySQLConnector() {
    connection();
  }

  static void connection() async {
    print('Conectando base de datos de MYSQL...');
    connector = await MySqlConnection.connect(_settings);
    print(
        'Conexión exitosa a la base de datos|||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
  }

  static void prueba(codigoPostal) async {
    var results = await connector.query(
        'select ageb.idageb,manz.geometry from ageb join manz on ageb.idageb = manz.idageb where ageb.codigoPostal=?;',
        [codigoPostal]);
    print(results);
  }
}
