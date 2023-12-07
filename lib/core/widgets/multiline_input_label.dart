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
  final focusNode = FocusNode();
  String initialText = "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding / 2),
      child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          onFieldSubmitted: widget.onSubmitted,
          cursorColor: Colors.white,
          minLines: 1,
          maxLines: 5,
          onTapOutside: (e) {
            focusNode.unfocus();
            String current = controller.text;
            if (current.isEmpty) {
              initialText = current;
              return;
            }
            if (current != initialText) {
              initialText = current;
              widget.onSubmitted(initialText);
            }
          },
          style: const TextStyle(
              fontSize: 18, fontFamily: kFontFamily, color: Colors.white),
          decoration: inputDecoration(labelText: widget.labelText)),
    );
  }
}
