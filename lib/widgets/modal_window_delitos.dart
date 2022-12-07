import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kitit/assets/colors.dart';

class Modalwindowdelitos {
  var context;
  static dynamic modal(BuildContext context, List list) {
    int index = list.length;
    print("tamaño de la lista de robos :      " + index.toString());
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: DesingColors.orange,

          title: Container(
            padding: EdgeInsets.only(top: 10),
            height: 50,
            color: Color(0xFFE84F0C),
            child: const Text(
              'DELITOS',
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          content: Container(
            decoration: BoxDecoration(

                // borderRadius: BorderRadius.circular(20),
                ),
            width: 500,
            height: 320,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                return Card(
                  child: ListTile(
                    tileColor: Colors.black,
                    // hoverColor: Colors.black,
                    title: Text(list[index]["delito"],
                        style: const TextStyle(color: Colors.white)),
                    // ignore: prefer_interpolation_to_compose_strings
                    subtitle: Text(
                      "Cantidad: ${list[index]["cantidad"]}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: const ImageIcon(
                      AssetImage("lib/_img/delincuente.png"),
                      color: Colors.white,
                    ),
                  ),
                );
              },
              itemCount: 5,
              // separatorBuilder: (_, __) => const Divider(),
            ),
          ),

          // SizedBox(
          //   height: 500,
          //   child: ListView.separated(
          //     itemBuilder: (context, int index) {
          //       return ListTile(
          //         title: Text('Item at $index'),
          //       );
          //     },
          //     itemCount: index,
          //     separatorBuilder: (_, __) => const Divider(),
          //   ),
          // ),
        );
      },
    );
  }

  static Widget buildItem(
    String textTitle,
    String subtitle,
  ) {
    return ListTile(
      title: Text(textTitle),
      subtitle: Text(subtitle),
      leading: const ImageIcon(
        AssetImage("lib/_img/delincuente.png"),
      ),
    );
  }
}
