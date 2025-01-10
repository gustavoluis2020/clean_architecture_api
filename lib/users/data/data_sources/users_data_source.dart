import 'package:clean_architecture_api/users/data/models/users_model.dart';

abstract class UsersDataSource {
  Future<List<UsersModel>> getUsers();
}
