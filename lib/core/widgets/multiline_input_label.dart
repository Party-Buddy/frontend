import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class MultiLineInputLabel extends StatefulWidget {
  const MultiLineInputLabel(
      {super.key, required this.onSubmitted, this.labelText});

  final Function(String) onSubmitted;
  final String? labelText;

  @override
  State<MultiLineInputLabel> createState() => _MultiLineInputLabelState();
}

class _MultiLineInputLabelState extends State<MultiLineInputLabel> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        onFieldSubmitted: widget.onSubmitted,
        cursorColor: Colors.white,
        minLines: 1,
        maxLines: 5,
        style: const TextStyle(
            fontSize: 18, fontFamily: kFontFamily, color: Colors.white),
        decoration: inputDecoration(labelText: widget.labelText));
  }
}
