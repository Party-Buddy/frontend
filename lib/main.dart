import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_games_app/core/injection_container.dart';
import 'package:party_games_app/party_games_app.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

Future<PartyGamesAppInitData> handleIntents() async {
  var uri = await ReceiveSharingIntent.getInitialTextAsUri();
  return PartyGamesAppInitData(inviteCode: uri?.queryParameters['invite-code']);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependenices();
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;

    WindowManager.instance.setMinimumSize(const Size(400, 800));
    WindowManager.instance.setMaximumSize(const Size(400, 800));
  }
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    ));
    var sid = await handleIntents();
    runApp(PartyGamesApp(initData: sid));
  } else {
    runApp(const PartyGamesApp());
  }
}
