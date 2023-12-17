import 'dart:io';

//const String serverDomain = '192.168.0.111'; // ip of the PC to play with the real phone
String get serverDomain => Platform.isAndroid ? "10.0.2.2" : "127.0.0.1";

const String serverWsPort = '9602';
const String serverHttpPort = '9602';
const String sessionPath = '/api/v1/session';
const String gamesPath = 'api/v1/games';
const String tasksPath = 'api/v1/tasks';
const List<String> joinSessionParams = ['session-id', 'invite-code'];