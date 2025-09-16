// lib/features/map/domain/repositories/location_repository_provider.dart
import 'package:latlong2/latlong.dart';


import '../entities/route.dart';
import '../entities/user_location.dart';

abstract class LocationRepository {
  Future<UserLocation> getCurrentLocation({required double lat,required double lon});
  Future<Route> getRoute({required LatLng start, required LatLng end});
}
