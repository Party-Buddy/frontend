import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';

class LabeledSlider extends StatefulWidget {
  const LabeledSlider({super.key,
                       required this.min, 
                       required this.max, 
                       required this.initial, 
                       required this.onChanged,
                       required this.displayValue});
  
  final int min;
  final int max;
  final int initial;
  final void Function(int) onChanged;
  final String Function(int) displayValue;

  @override
  State<StatefulWidget> createState() => _LabeledSliderState();
}

class _LabeledSliderState extends State<LabeledSlider> {
  late int currValue = widget.initial;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BorderWrapper(
          child: Text(widget.displayValue(currValue),
              style: standardTextStyle(),)),
        const SizedBox(height: kPadding,),
        Slider(
          activeColor: kPrimaryColor.withOpacity(.8),
          thumbColor: kPrimaryColor,
          inactiveColor: kPrimaryColor.withOpacity(.3),
          value: currValue.toDouble(),
          min: widget.min.toDouble(),
          max: widget.max.toDouble(),
          onChanged: (newVal) {
            setState(() {
              currValue = newVal.round();
              widget.onChanged(currValue);
            });
          })
            
    ],);
  }
}
