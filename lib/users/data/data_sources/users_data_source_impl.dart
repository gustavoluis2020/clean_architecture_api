import 'dart:convert';
import 'package:clean_architecture_api/users/data/data_sources/users_data_source.dart';
import 'package:clean_architecture_api/users/data/models/users_model.dart';
import 'package:http/http.dart' as http;

class UsersDataSourceImpl implements UsersDataSource {
  final http.Client client;

  UsersDataSourceImpl({required this.client});

  @override
  Future<List<UsersModel>> getUsers() async {
    try {
      final response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if (response.statusCode == 200) {
        final List decodedJson = json.decode(response.body);
        return decodedJson.map((json) => UsersModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
