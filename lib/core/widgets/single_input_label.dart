import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

enum SubmitResult { success, error, empty }

class SingleLineInputLabel extends StatefulWidget {
  const SingleLineInputLabel(
      {super.key, required this.onSubmitted, this.labelText});

  final Future<SubmitResult> Function(String) onSubmitted;
  final String? labelText;

  @override
  State<SingleLineInputLabel> createState() => _SingleLineInputLabelState();
}

class _SingleLineInputLabelState extends State<SingleLineInputLabel> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  SubmitResult submitResult = SubmitResult.empty;
  String initialText = "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color get shadowColor => switch (submitResult) {
        SubmitResult.success => const Color.fromARGB(255, 64, 238, 70),
        SubmitResult.error => Colors.red,
        _ => Colors.transparent
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPadding / 2),
      decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          boxShadow: submitResult == SubmitResult.empty
              ? []
              : [BoxShadow(color: shadowColor, blurRadius: 10)]),
      child: TextField(
        controller: controller,
        onSubmitted: (s) async {
          var result = await widget.onSubmitted(s);
          setState(() {
            s = s.trim();
            initialText = s;
            submitResult = result;
          });
        },
        cursorColor: Colors.white,
        focusNode: focusNode,
        onTapOutside: (e) async {
          focusNode.unfocus();
          String current = controller.text;
          if (current.isEmpty) {
            initialText = current;
            setState(() {
              submitResult = SubmitResult.empty;
            });
            return;
          }

          if (current != initialText) {
            initialText = current;
            var result = await widget.onSubmitted(current);
            setState(() {
              submitResult = result;
            });
          }
        },
        style: const TextStyle(
            fontSize: 18, fontFamily: kFontFamily, color: Colors.white),
        decoration: inputDecoration(labelText: widget.labelText),
      ),
    );
  }
}
