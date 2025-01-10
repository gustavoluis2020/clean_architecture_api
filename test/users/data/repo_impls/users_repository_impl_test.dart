import 'package:clean_architecture_api/core/helpers/use_case.dart';
import 'package:clean_architecture_api/users/data/data_sources/users_data_source.dart';
import 'package:clean_architecture_api/users/data/errors/exceptions.dart';
import 'package:clean_architecture_api/users/data/models/address_model.dart';
import 'package:clean_architecture_api/users/data/models/company_model.dart';
import 'package:clean_architecture_api/users/data/models/geo_model.dart';
import 'package:clean_architecture_api/users/data/models/users_model.dart';
import 'package:clean_architecture_api/users/data/repo_impls/users_repository_impl.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUsersDataSource extends Mock implements UsersDataSource {}

void main() {
  late MockUsersDataSource mockUsersDataSource;
  late UsersRepositoryImpl usersRepository;

  setUp(() {
    mockUsersDataSource = MockUsersDataSource();
    usersRepository = UsersRepositoryImpl(usersDataSource: mockUsersDataSource);
  });

  test('should return Right with a list of Users Entity when the call is successful', () async {
    // Arrange
    final users = [
      UsersModel(
        name: 'Test User',
        id: 1,
        username: '',
        email: '',
        address: AddressModel(
          street: 'street',
          suite: 'suite',
          city: 'city',
          zipcode: 'zipcode',
          geo: GeoModel(lat: 'lat', lng: 'lng'),
        ),
        phone: '',
        website: '',
        company: CompanyModel(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs'),
      ),
    ];
    when(() => mockUsersDataSource.getUsers()).thenAnswer((_) async => users);
    // Act
    final result = await usersRepository.getUsers();
    // Assert
    expect(result, isA<Right<Failure, List<UsersEntity>>>());
    result.fold(
      (failure) => fail('Expected a Right but got a Left'),
      (users) => expect(users, isA<List<UsersEntity>>()),
    );
  });

  test('should return Left with a User not found exception when the call is unsuccessful', () async {
    // Arrange
    when(() => mockUsersDataSource.getUsers()).thenThrow(UsersNotFoundException('error'));
    // Act
    final result = await usersRepository.getUsers();
    // Assert
    expect(result, isA<Left<Failure, List<UsersEntity>>>());
    result.fold(
      (failure) => expect(failure, isA<UsersNotFoundException>()),
      (users) => fail('Expected a Left but got a Right'),
    );
  });
}
