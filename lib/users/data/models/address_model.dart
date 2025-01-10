import 'package:clean_architecture_api/users/data/models/geo_model.dart';
import 'package:clean_architecture_api/users/domain/entities/address_entity.dart';

class AddressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoModel geo;

  AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: GeoModel.fromJson(json["geo"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo.toJson(),
      };

  AddressEntity toEntity() => AddressEntity(
        street: street,
        suite: suite,
        city: city,
        zipcode: zipcode,
        geo: geo.toEntity(),
      );
}
