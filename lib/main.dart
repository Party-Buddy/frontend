import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_games_app/core/injection_container.dart';
import 'package:party_games_app/party_games_app.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
