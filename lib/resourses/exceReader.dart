import 'dart:ffi';

import 'package:gsheets/gsheets.dart';

class ExcelReader {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "kitit-361617",
  "private_key_id": "782eceb3e054e5f8f4d5bf0b12a4bdee56287798",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCgu08jmB7pnUW/\nxj5YtCKUslasvdjOTwfklz3xBgbQRW2/mvOVagkx+4U5jn979E2KVLZEHxXoJMc2\nXspjA1h98EJ6M9wAc2fu16bN7Vj5MFs8xOkgahBAoBMxmeRjXz+/7NXX0h4Iqqt9\ns0klaPvYNDiasmxcP7S06gPSpoblL26rIW56Nvo8ed3Z+12bHpDRW4md+a3vBZaw\n7EO3UYIIKJoNalGqbvfCJh1V/wiCwbKl3BIuF3uSK3+W99frQ6v2OhPRN7sAW74j\nQXjOCID57Pcrta5i113sKKgAD9vfg34cOVlL/qar0dvqicDbCqUa8C3v0WgqiJOz\nrpdsWKPjAgMBAAECggEABmUCqa3cUlBZfV8Lt/JitdEVNbDP4VVaQQlArkgebpwf\nLlJMgpNCDmUCpd7kyi+sA2bfYX0YcrCT5GEyYsINUTqvymDUeIge3cJioSq3hs0a\nXs6OtSVtxBnE6beaUyxvmC559ijRMmhn2OEQdevj/nQFadIovCV6BlXmal5fBjB5\nZUMP1alJkdfmw3EE1i/07mmsmVkUCtpvU2gnZ3Es1/cWXHa+VKw498HwuoKGsDVH\nldcnGrfwTAlUwVS/2xzizV+LEMEHZcAm1trOwkGzmjLtOqDp+WTFF9805K2U7WvH\nqLmzkbLEjt5fnoWEuhi3xoNaoE087zSYjSQqjJcQUQKBgQDYgQEdWWnCvTVQxXVC\n2IJKlePxf/ubfxCw1TwwGPaYxpFA1VKEj++I+rpKqywxyQXn002gSDFP3xdLYCzR\nV16NV/mw32PeG9Mg8H5W7GhdYHyFOjgGkeZtX/S/MLZIvRj4zRJo8HYTU1iYYxmU\nFj5u9vkY7BYselg8z0pyY7NwHQKBgQC+DaxZ9Y5B/XRGUiPC/uIjLUTlpelh17k/\n4FIh7YAgt3wm7V085Rizk1wQzoFLGbIgAJC1ZW/KkI3wy1y++1/LEgKNdk1Vx5Sq\nYxqN+e4cijOPtEZqplJKfLnCEjMgB3GuK3nHHQ4U2qP1e4tY/VdRpGkgTo+21WoH\nx/plwugj/wKBgD7s/83v9vVK2Pwo5/QNyZC0EBRZBmAjhk5fK6cvGj09OWqGlf1B\neHVvqkWZirbNnpHKsH0tfmegh7y4r04I/spGD6SAyR39KFgijhXlkE/Tg12VlkMS\nlM6lXRVUqyZpD6EAuaEWgrsLNmzUINMRxAOsdKnxtGApDwxdk1277KNhAoGBAJM8\nXI3E4tTU2kOwVuw2MlM2Ou3+vvOCAI4v5vFJ4b126MPvmBAZHC3it6x9j0TzPz/z\nsCgX0aeIna4ynkOG0wurhDa7s+YEnHP0GxpqycFqf8+QxgzRlWcHgZGML/dcTQG1\nxL4xEDuvtt3zPF1Qx1kEmjzhIA1xAJfOoXo8qUNZAoGAD+VrIzsCYzEhSBnRUsuf\nFSP/NkeNjQ7M/4R/PyoH+vugQXjSWriwIr1dLpc+otsge9orWR0oFCocJXRIgfQx\n1FERrzcaHojfxGWjorie455ET4cI3pI1dJmuhOkJbQcFxRcy7wMePUWS4BY/e6J6\nJBz9iYWzqkXwJ0rktinJOAY=\n-----END PRIVATE KEY-----\n",
  "client_email": "googlesheetservice@kitit-361617.iam.gserviceaccount.com",
  "client_id": "115181656450078596895",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/googlesheetservice%40kitit-361617.iam.gserviceaccount.com"
}
  ''';
  static const _spreedSheetId = '1hbxDEXj7bvZ-zFCdemxb1c9xZ_-LYLLgiSV4P76U8rQ';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _converter;

  static Future init() async {
    print('Conectando al a hoja de calculo...');
    final spreadsheet = await _gsheets.spreadsheet(_spreedSheetId);
    _converter =
        await _getWorkSheet(spreadsheet, title: 'Cálculo de Coordenadas');
    print('|| Conectada a la hoja de calculo ||');
  }

  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    return await spreadsheet.worksheetByTitle(title);
  }

  static Future<List<double>> modifyLatAndLon(double lat, double long) async {
    print(await _converter!.values.value(column: 1, row: 2));
    print(await _converter!.values.value(column: 2, row: 2));

    await _converter!.values.insertValue(lat, column: 2, row: 2);
    await _converter!.values.insertValue(long, column: 1, row: 2);

    double east =
          double.parse(await _converter!.values.value(column: 30, row: 2));
    double north =
        double.parse(await _converter!.values.value(column: 31, row: 2));

    return [east,north];

    // 31
  }
}
