import 'package:flutter/material.dart';
import 'package:kitit/assets/colors.dart';

class SliderPrice extends StatefulWidget {
  final ValueChanged<RangeValues> rangeValue;
  const SliderPrice({super.key, required this.rangeValue});

  @override
  State<SliderPrice> createState() => _SliderPriceState();
}

class _SliderPriceState extends State<SliderPrice> {
  static double _maxValue = 200000;
  static double _minValue = 50000;

  RangeValues values = RangeValues(_minValue, _maxValue);
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: DesingColors.orange,
      inactiveColor: Color.fromARGB(255, 38, 38, 38),
      min: 1000,
      max: 250000,
      divisions: 249,
      labels: RangeLabels('\$${values.start.round().toString()}',
          '\$${values.end.round().toString()}'),
      values: values,
      onChanged: (RangeValues value) {
        setState(() {
          values = value;
          widget.rangeValue(value);
        });
      },
    );
  }
}
