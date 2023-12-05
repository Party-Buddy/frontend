import 'package:party_games_app/features/user_data/domain/entities/username.dart';

class UsernameModel {
  String? username;
  ({int a, int r, int g, int b})? color;
  
  UsernameModel({this.username, this.color});

  factory UsernameModel.fromEntity(Username entity){
    return UsernameModel(
      username: entity.username,
      color: entity.color
    );
  }

}