import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

class FutureBuilderWrapper<T> extends StatelessWidget {
  const FutureBuilderWrapper({super.key, required this.future, required this.notFoundWidget, required this.builder});

  final Future<T> future;
  final Widget Function() notFoundWidget;
  final Widget Function(T) builder;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: future, builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
        return snapshot.data == null ? notFoundWidget() : builder(snapshot.data!);
          case ConnectionState.none:
        return notFoundWidget();
          case ConnectionState.waiting:
        return const CircularProgressIndicator(color: kPrimaryColor,);
          case ConnectionState.active:
        return const CircularProgressIndicator(color: kPrimaryColor,);
        }
      });
  }
}
