import 'package:clean_architecture_api/users/domain/entities/address_entity.dart';
import 'package:clean_architecture_api/users/domain/entities/company_entity.dart';

class UsersEntity {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressEntity address;
  final String phone;
  final String website;
  final CompanyEntity company;

  UsersEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });
}
