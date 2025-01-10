import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:clean_architecture_api/core/helpers/use_case.dart';
import 'package:dartz/dartz.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UsersEntity>>> getUsers();
}
