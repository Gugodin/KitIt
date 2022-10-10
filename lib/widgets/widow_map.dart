import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class window_map extends StatelessWidget {
  var data;
  window_map({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    CustomInfoWindowController _customInfoWindowController =
        CustomInfoWindowController();
    return Container(
      height: 500,
      width: 500,
      color: Colors.amber,
      child: Text("${data}"),
    );
  }
}
