// lib/features/map/data/models/user_location_model.dart

import '../../domain/entities/user_location.dart';

class UserLocationModel extends UserLocation {
  const UserLocationModel({
    required super.latitude,
    required super.longitude,
  });

  /// Create model from JSON
  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      latitude: double.tryParse(json['lat'])?? 0.0,
      longitude: double.tryParse(json['lon'] ) ?? 0.0 ,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lon': longitude,
    };
  }
}
