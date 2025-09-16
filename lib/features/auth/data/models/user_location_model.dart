// // lib/features/map/data/models/user_location_model.dart
//
// import '../../domain/entities/user_location.dart';
//
// class UserLocationModel extends UserLocation {
//   const UserLocationModel({
//     required double latitude,
//     required double longitude,
//   }) : super(latitude: latitude, longitude: longitude);
//
//   /// Create model from JSON
//   factory UserLocationModel.fromJson(Map<String, dynamic> json) {
//     return UserLocationModel(
//       latitude: (json['latitude'] as num).toDouble(),
//       longitude: (json['longitude'] as num).toDouble(),
//     );
//   }
//
//   /// Convert model to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'latitude': latitude,
//       'longitude': longitude,
//     };
//   }
// }
