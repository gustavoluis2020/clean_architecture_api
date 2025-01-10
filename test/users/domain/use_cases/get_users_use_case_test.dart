import 'package:clean_architecture_api/core/helpers/failures.dart';
import 'package:clean_architecture_api/users/data/errors/exceptions.dart';
import 'package:clean_architecture_api/users/domain/entities/address_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/company_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/geo_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:clean_architecture_api/users/domain/repositories/users_repository.dart';
import 'package:clean_architecture_api/users/domain/use_cases/get_users_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUsersRepository extends Mock implements UsersRepository {}

void main() {
  late GetUsersUseCase usecase;
  late MockUsersRepository mockUsersRepository;

  setUp(() {
    mockUsersRepository = MockUsersRepository();
    usecase = GetUsersUseCase(usersRepository: mockUsersRepository);
  });

  group('GetUsersUseCase', () {
    test('should return Right(List<UsersEntity>) when successful', () async {
      // arrange
      final List<UsersEntity> tUsers = [
        UsersEntity(
          name: 'Test User',
          id: 1,
          username: 'testuser',
          email: '',
          address: AddressEntity(
              street: 'street',
              suite: 'suite',
              city: 'city',
              zipcode: 'zipcode',
              geo: GeoEntity(lat: 'lat', lng: 'lng')),
          phone: '',
          website: '',
          company: CompanyEntity(
            name: 'name',
            catchPhrase: 'catchPhrase',
            bs: 'bs',
          ),
        )
      ];
      when(() => mockUsersRepository.getUsers()).thenAnswer((_) async => Right(tUsers));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, Right(tUsers));
    });

    test('should return Left(UsersNotFoundException) when unsuccessful', () async {
      // arrange
      when(() => mockUsersRepository.getUsers()).thenAnswer((_) async => Left(UsersNotFoundException('')));

      // act
      final result = await usecase(NoParams());

      // assert
      final failure = result.fold(id, id);
      expect(failure, isA<UsersNotFoundException>());
    });
  });
}
