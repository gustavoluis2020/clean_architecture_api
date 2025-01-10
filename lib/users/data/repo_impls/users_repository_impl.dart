import 'package:clean_architecture_api/users/data/data_sources/users_data_source.dart';
import 'package:clean_architecture_api/users/data/errors/exceptions.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:clean_architecture_api/users/domain/repositories/users_repository.dart';
import 'package:clean_architecture_api/core/helpers/use_case.dart';
import 'package:dartz/dartz.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDataSource usersDataSource;

  UsersRepositoryImpl({required this.usersDataSource});

  @override
  Future<Either<Failure, List<UsersEntity>>> getUsers() async {
    try {
      final users = await usersDataSource.getUsers();
      return Right(users.map((e) => e.toEntity()).toList());
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
    }

    return Left(UsersNotFoundException('Users not found'));
  }
}
