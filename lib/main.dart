import 'package:flutter/material.dart';
import 'package:party_games_app/core/injection_container.dart';
import 'package:party_games_app/party_games_app.dart';

void main() {
  initializeDependenices();
  runApp(const PartyGamesApp());
}
