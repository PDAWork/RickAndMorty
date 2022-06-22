import 'package:rick_and_morty/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required String name,
    required String url,
  }) : super(
          name: name,
          url: url,
        );

  factory LocationModel.from(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
