import '../../domain/entities/place.dart';

class PlaceModel extends Place{


  PlaceModel({
    required super.placeId,
    required super.licence,
    required super.osmType,
    required super.osmId,
    required super.lat,
    required super.lon,
    required super.placeClass,
    required super.type,
    required super.placeRank,
    required super.importance,
    required super.addresstype,
    required super.name,
    required super.displayName,
    required super.boundingbox,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      placeId: json['place_id'],
      licence: json['licence'],
      osmType: json['osm_type'],
      osmId: json['osm_id'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
      placeClass: json['class'],
      type: json['type'],
      placeRank: json['place_rank'],
      importance: (json['importance'] as num).toDouble(),
      addresstype: json['addresstype'],
      name: json['name'],
      displayName: json['display_name'],
      boundingbox: (json['boundingbox'] as List)
          .map((e) => double.parse(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'place_id': placeId,
    'licence': licence,
    'osm_type': osmType,
    'osm_id': osmId,
    'lat': lat.toString(),
    'lon': lon.toString(),
    'class': placeClass,
    'type': type,
    'place_rank': placeRank,
    'importance': importance,
    'addresstype': addresstype,
    'name': name,
    'display_name': displayName,
    'boundingbox': boundingbox.map((e) => e.toString()).toList(),
  };
}
