import 'dart:async';
import 'package:flutter/material.dart';
import 'package:party_games_app/config/app_config.dart';
import 'package:party_games_app/config/routes/app_routes.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/features/games/presentation/screens/game_join_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class PartyGamesAppInitData {
  String? inviteCode;

  PartyGamesAppInitData({this.inviteCode});
}

class PartyGamesApp extends StatefulWidget {
  const PartyGamesApp({super.key, this.initData});

  final PartyGamesAppInitData? initData;

  @override
  State<PartyGamesApp> createState() => _PartyGamesAppState();
}

class _PartyGamesAppState extends State<PartyGamesApp> {
  late final StreamSubscription _streamSubscription;
  final _navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    if (widget.initData == null) {
      return;
    }
    _streamSubscription =
        ReceiveSharingIntent.getTextStreamAsUri().listen((uriEvent) {
      String? uri = uriEvent.queryParameters['invite-code'];
      if (uri != null) {
        _navKey.currentState!.pushNamed(GameJoinScreen.routeName,
            arguments: GameJoinScreenArguments(inviteCode: uri));
      } else {
        _navKey.currentState!.pushNamed(GameJoinScreen.routeName);
      }
    });
    var initUri = widget.initData!.inviteCode;
    if (initUri != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navKey.currentState!.pushNamed(GameJoinScreen.routeName,
            arguments: GameJoinScreenArguments(inviteCode: initUri));
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
      debugShowCheckedModeBanner: false,
      title: kTitle,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const MainMenuScreen(),
    );
  }
}
