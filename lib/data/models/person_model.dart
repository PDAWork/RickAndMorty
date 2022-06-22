import 'package:rick_and_morty/data/models/location_model.dart';
import 'package:rick_and_morty/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required int id,
    required name,
    required status,
    required species,
    required type,
    required gender,
    required origin,
    required location,
    required image,
    required episode,
    required created,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
          origin: origin,
          location: location,
          image: image,
          episode: episode,
          created: created,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin:
          json['origin'] != null ? LocationModel.from(json['origin']) : null,
      location: json['location'] != null
          ? LocationModel.from(json['location'])
          : null,
      image: json['image'],
      episode: (json['episode'] as List).map((e) => e as String).toList(),
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': LocationModel(name: location.name, url: location.url).toJson(),
      'location':
          LocationModel(name: location.name, url: location.url).toJson(),
      'image': image,
      'episode': episode,
      'created': created.toIso8601String(),
    };
  }
}
