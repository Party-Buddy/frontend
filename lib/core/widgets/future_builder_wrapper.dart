import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';

class FutureBuilderWrapper<T> extends StatelessWidget {
  const FutureBuilderWrapper(
      {super.key,
      required this.future,
      required this.notFoundWidget,
      required this.builder,
      this.delayRatio = 3});

  final Future<T> future;
  final Widget Function() notFoundWidget;
  final Widget Function(T) builder;
  final int delayRatio;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(kAnimationDuration * delayRatio, () => future),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return snapshot.data == null
                  ? notFoundWidget()
                  : builder(snapshot.data!);
            case ConnectionState.none:
              return notFoundWidget();
            case ConnectionState.waiting:
              return loadingWidget();
            case ConnectionState.active:
              return loadingWidget();
          }
        });
  }

  Widget loadingWidget() {
    return Container(
      height: 200,
      width: 200,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: kPrimaryColor,),
    );
  }
}
