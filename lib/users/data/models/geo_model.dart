import 'package:clean_architecture_api/users/domain/entities/geo_entity.dart';

class GeoModel {
  final String lat;
  final String lng;

  GeoModel({
    required this.lat,
    required this.lng,
  });

  factory GeoModel.fromJson(Map<String, dynamic> json) => GeoModel(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };

  GeoEntity toEntity() => GeoEntity(
        lat: lat,
        lng: lng,
      );
}
