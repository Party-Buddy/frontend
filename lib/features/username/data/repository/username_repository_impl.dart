import 'package:party_games_app/config/defaults/username.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/username/data/data_sources/local/local_username_datasource.dart';
import 'package:party_games_app/features/username/data/model/username_model.dart';
import 'package:party_games_app/features/username/domain/entities/username.dart';
import 'package:party_games_app/features/username/domain/repository/username_repository.dart';

class UsernameRepositoryImpl implements UsernameRepository {

  final LocalUsernameDatasource localUsernameDatasource;

  UsernameRepositoryImpl(this.localUsernameDatasource);

  @override
  Future<Username> getSavedOrDefaultUsername() async{
    var username = await localUsernameDatasource.getSavedUsername();
    return Username(
      username: username.username ?? defaultUsername.username,
      color: username.color ?? defaultUsername.color
      );
  }

  @override
  Future<void> saveUsername(Username username) async{
    localUsernameDatasource.saveUsername(UsernameModel.fromEntity(username));
  }

}