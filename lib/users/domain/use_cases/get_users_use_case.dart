import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:clean_architecture_api/users/domain/repositories/users_repository.dart';
import 'package:clean_architecture_api/core/helpers/failures.dart';
import 'package:clean_architecture_api/core/helpers/use_case.dart';
import 'package:dartz/dartz.dart';

class GetUsersUseCase extends UseCase<List<UsersEntity>, NoParams> {
  final UsersRepository usersRepository;

  GetUsersUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, List<UsersEntity>>> call(NoParams params) async {
    return usersRepository.getUsers();
  }
}
