import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen(
      {super.key,
      required this.content,
      this.appBarTitle,
      this.showBackButton = true,
      this.resizeToAvoidBottomInset = false});

  final String? appBarTitle;
  final Widget content;
  final bool showBackButton;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kBackgroundGradient),
      child: Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: Colors.transparent,
          appBar: appBarTitle == null
              ? null
              : AppBar(
                  automaticallyImplyLeading: showBackButton,
                  leading: showBackButton ? backButton(context) : null,
                  title: Text(appBarTitle!)),
          body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: kPaddingAll.add(const EdgeInsets.only(bottom: kPadding)),
              child: content)),
    );
  }
}
