import 'package:clean_architecture_api/users/controller/users_controller.dart';
import 'package:clean_architecture_api/users/data/data_sources/users_data_source_impl.dart';
import 'package:clean_architecture_api/users/data/repo_impls/users_repository_impl.dart';
import 'package:clean_architecture_api/users/domain/repositories/users_repository.dart';
import 'package:clean_architecture_api/users/domain/use_cases/get_users_use_case.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersBinding implements Bindings {
  final client = http.Client();
  @override
  void dependencies() {
    final UsersRepository usersRepository = UsersRepositoryImpl(
      usersDataSource: UsersDataSourceImpl(client: client),
    );

    Get.lazyPut<GetUsersUseCase>(
      () => GetUsersUseCase(usersRepository: usersRepository),
      fenix: true,
    );

    Get.lazyPut<UsersController>(() => UsersController());
  }
}
