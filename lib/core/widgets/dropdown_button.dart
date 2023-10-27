import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {super.key,
      required this.question,
      required this.answerPrefix,
      required this.items,
      required this.onChanged});

  final List<String> items;
  final void Function(String?) onChanged;
  final String question;
  final String answerPrefix;

  @override
  State<StatefulWidget> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
      customButton: Container(
        width: double.infinity,
        padding: kPaddingAll,
        decoration: BoxDecoration(
            borderRadius: kBorderRadius,
            color: kInputLabelBackgroundColor.withOpacity(.8),
            border: Border.all(color: kBorderColor)),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              value == null
                  ? widget.question
                  : "${widget.answerPrefix}: $value",
              style: const TextStyle(
                color: kFontColor,
                fontSize: 18,
                fontFamily: kFontFamily,
              ),
            )),
      ),
      dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: kBorderRadius,
              color: kInputLabelBackgroundColor.withOpacity(.8))),
      items: widget.items
          .map((itemName) => DropdownMenuItem<String>(
              value: itemName,
              child: Text(
                itemName,
                style: const TextStyle(
                  color: kFontColor,
                  fontSize: 18,
                  fontFamily: kFontFamily,
                ),
              )))
          .toList(),
      onChanged: (itemName) {
        setState(() {
          value = itemName;
        });
        widget.onChanged(itemName);
      },
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontFamily: kFontFamily,
      ),
    ));
  }
}
