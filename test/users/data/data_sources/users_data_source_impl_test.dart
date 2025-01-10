import 'dart:convert';
import 'package:clean_architecture_api/users/data/data_sources/users_data_source_impl.dart';
import 'package:clean_architecture_api/users/data/models/address_model.dart';
import 'package:clean_architecture_api/users/data/models/company_model.dart';
import 'package:clean_architecture_api/users/data/models/geo_model.dart';
import 'package:clean_architecture_api/users/data/models/users_model.dart';
import 'package:clean_architecture_api/users/domain/repositories/users_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class UriFake extends Fake implements Uri {}

class MockUsersRepository extends Mock implements UsersRepository {}

void main() {
  late UsersDataSourceImpl usersDataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    registerFallbackValue(UriFake());
    mockHttpClient = MockHttpClient();
    usersDataSourceImpl = UsersDataSourceImpl(client: mockHttpClient);
  });

  test('should return a list of Users Model when the result is successful', () async {
    // Arrange
    final tUsersModels = [
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

    when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response(jsonEncode(tUsersModels), 200));

    //act
    final result = await usersDataSourceImpl.getUsers();

    //assert
    expect(result, isA<List<UsersModel>>());
  });

  test('should throw Exception when the call to API fails', () async {
    // Arrange
    when(() => mockHttpClient.get(any())).thenAnswer(
      (_) async => http.Response('Error', 404),
    );

    // Act
    final call = usersDataSourceImpl.getUsers();

    // Assert
    expect(() => call, throwsA(isA<Exception>()));
  });
}
