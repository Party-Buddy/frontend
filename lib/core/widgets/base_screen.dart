import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.content, this.appBarTitle});

  final String? appBarTitle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kBackgroundGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBarTitle == null
              ? null
              : AppBar(
                  leading: backButton(context),
                  title: Text(appBarTitle!)
                ),
          body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: kPaddingAll.add(const EdgeInsets.only(bottom: kPadding)),
              child: content)),
    );
  }
}
