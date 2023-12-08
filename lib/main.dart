import 'package:flutter/material.dart';
import 'package:party_games_app/core/injection_container.dart';
import 'package:party_games_app/party_games_app.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

Future<PartyGamesAppInitData> handleIntents() async{
  var uri = await ReceiveSharingIntent.getInitialTextAsUri();
  return PartyGamesAppInitData(inviteCode: uri?.queryParameters['invite-code']);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependenices();
  var sid = await handleIntents();
  runApp(PartyGamesApp(initData:sid));
}
