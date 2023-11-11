import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';

class CustomDropDownButton<T> extends StatefulWidget {
  const CustomDropDownButton(
      {super.key,
      required this.initialItem,
      required this.items,
      required this.stringMapper,
      required this.onChanged});

  final List<T> items;
  final T initialItem;
  final void Function(T) onChanged;
  final String Function(T) stringMapper;

  @override
  State<CustomDropDownButton<T>> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState<T> extends State<CustomDropDownButton<T>> {
  late T current = widget.initialItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
      // customButton: CustomButton(text: widget.stringMapper(current), width: 100, onPressed: () {}),
      customButton: BorderWrapper(
          child: Container(
        alignment: Alignment.center,
        width: 100,
        padding: const EdgeInsets.all(kPadding * .08),
        child: Text(widget.stringMapper(current)),
      )),
      dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: kBorderRadius,
              color: kAppBarColor.withOpacity(.8))),
      items: widget.items
          .map((item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                widget.stringMapper(item),
                style: defaultTextStyle(),
              )))
          .toList(),
      onChanged: (item) {
        if (item == null) return;
        setState(() {
          current = item;
        });
        widget.onChanged(item);
      },
      style: defaultTextStyle(),
    ));
  }
}
