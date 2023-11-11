import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.content, this.appBarTitle});

  final String? appBarTitle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgorundColor,
        appBar: appBarTitle == null
            ? null
            : AppBar(
                leading: backButton(context),
                title: Text(appBarTitle!),
              ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(gradient: kBackgroundGradient),
            padding: kPaddingAll.add(const EdgeInsets.only(bottom: kPadding)),
            child: content));
  }
}
