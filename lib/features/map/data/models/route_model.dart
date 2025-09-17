import 'package:latlong2/latlong.dart';

import '../../domain/entities/route.dart';

class RouteModel extends RouteEntity {

  RouteModel({
    required super.points,
    required super.distance,
    required super.duration,
  });

  // من JSON المستلم من OSRM
  factory RouteModel.fromJson(Map<String, dynamic> json) {
    final coordinates = json['routes'][0]['geometry']['coordinates'] as List;
    final points = coordinates.map<LatLng>((c) => LatLng(c[1], c[0])).toList();
    final distance = (json['routes'][0]['distance'] as num).toDouble();
    final duration = (json['routes'][0]['duration'] as num).toDouble();

    return RouteModel(
      points: points,
      distance: distance,
      duration: duration,
    );
  }

  }