import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:kitit/service/datos_predios.dart';

class ventana_modal_view extends StatefulWidget {
  const ventana_modal_view({super.key});

  @override
  State<ventana_modal_view> createState() => _ventana_modal_viewState();
}

class _ventana_modal_viewState extends State<ventana_modal_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ventana modal"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Modal window'),
          onPressed: () {
            data_predio().then((value) {
              //redondeo de cus
              List<Text> usos_permitidos_list = [];
              List<Text> usos_no_permitidos_list = [];
              String inStringCus = value[0]["cus"].toStringAsFixed(2); // '2.35'
              double inDoubleCus = double.parse(inStringCus);

              var usos_permitidos =
                  value[0]["zonificacion_default"]["usos_permitidos"];
              var usos_no_permitidos =
                  value[0]["zonificacion_default"]["usos_condicionados"];

              for (var tipo_uso in usos_permitidos) {
                String? tipo_uso_string = tipos_uso_nombre[tipo_uso];
                var texto = Text(tipo_uso_string!);
                usos_permitidos_list.add(texto);
              }
              for (var tipo_uso_no in usos_no_permitidos) {
                String? tipo_uso_no_string = tipos_uso_nombre[tipo_uso_no];
                var texto = Text(tipo_uso_no_string!);
                usos_no_permitidos_list.add(texto);
              }

              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 600,
                    child: Center(
                      child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Clave Catastral: ${value[0]["clave"]}"),
                              Text("Tipo: ${value[0]["tipo"]}"),
                              Text("ubicacion:  ${value[0]["ubicacion"]}"),
                              Text("colonia: ${value[0]["colonia"]}"),
                              Text(
                                  "Superficie de Terreno: Escritura - ${value[0]["superficieLegal"].toString()} m2"),
                              Text(
                                  "Superficie de Terreno: Cartografía - ${value[0]["superficieCarto"].toStringAsFixed(2)} m2"),
                              Text(
                                  "Superficie Construida: ${value[0]["superficieConstruccion"].toString()} m2"),
                              Text(
                                  "Frente de Predio: ${value[0]["frente"].toString()} m"),
                              Text(
                                  "Zonificacion: ${value[0]["clave"].toString()}"),
                              Text(
                                  "COS: ${value[0]["cos"].toStringAsFixed(2)}"),
                              Text(
                                  "COS:  ${value[0]["zonificacion_default"]["cos"].toString()} 0"),
                              Text("CUS: ${inDoubleCus.toString()}"),
                              Text(
                                  "CUS permitido:  ${value[0]["zonificacion_default"]["cus_max"].toString()}"),
                            ],
                          ),
                          Divider(),
                          const Text(
                            'Usos Permitidos',
                            style: TextStyle(fontSize: 20),
                          ),
                          Column(children: usos_permitidos_list),
                          Divider(),
                          const Text(
                            'Usos Condicionados',
                            style: TextStyle(fontSize: 20),
                          ),
                          Column(children: usos_no_permitidos_list),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
          },
        ),
      ),
    );
  }
}
