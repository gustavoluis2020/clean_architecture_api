import 'package:clean_architecture_api/users/data/models/address_model.dart';
import 'package:clean_architecture_api/users/data/models/company_model.dart';
import 'package:clean_architecture_api/users/domain/entities/users_entity.dart';

class UsersModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressModel address;
  final String phone;
  final String website;
  final CompanyModel company;

  UsersModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: AddressModel.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company: CompanyModel.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toJson(),
        "phone": phone,
        "website": website,
        "company": company.toJson(),
      };

  UsersEntity toEntity() => UsersEntity(
        id: id,
        name: name,
        username: username,
        email: email,
        address: address.toEntity(),
        phone: phone,
        website: website,
        company: company.toEntity(),
      );
}
