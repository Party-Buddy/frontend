import 'package:party_games_app/config/defaults/username.dart';
import 'package:party_games_app/features/user_data/data/data_sources/local/local_datasource.dart';
import 'package:party_games_app/features/user_data/data/model/username_model.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';
import 'package:party_games_app/features/user_data/domain/repository/user_data_repository.dart';
import 'package:uuid/v4.dart';

class UsernameRepositoryImpl implements UsernameRepository {

  final LocalUsernameDatasource localDatasource;

  UsernameRepositoryImpl(this.localDatasource);

  @override
  Future<Username> getSavedOrDefaultUsername() async{
    var username = await localDatasource.getSavedUsername();
    return Username(
      username: username.username ?? defaultUsername.username,
      color: username.color ?? defaultUsername.color
      );
  }

  @override
  Future<void> saveUsername(Username username) async{
    localDatasource.saveUsername(UsernameModel.fromEntity(username));
  }
  
  @override
  Future<String> getUserId() async{
    var uid = await localDatasource.getUID();
    if (uid == null){
      uid = const UuidV4().generate();
      await localDatasource.saveUID(uid);
    }
    return uid;
  }

}