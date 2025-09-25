import 'package:latlong2/latlong.dart';
import 'package:taxi_test/features/map/data/data_sources/location_remote_data_source.dart';
import 'package:taxi_test/features/map/data/models/route_model.dart';
import 'package:taxi_test/features/map/domain/entities/user_location.dart';
import 'package:taxi_test/features/map/domain/repositories/location_repository.dart';
import '../data_sources/routing_remote_data_source.dart';
import '../models/place_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;
  final RouteRemoteDataSource routeRemoteDataSource;

  LocationRepositoryImpl(
      this.locationRemoteDataSource, this.routeRemoteDataSource);
  @override
  Future<UserLocation> getCurrentLocation(
      {required double lat, required double lon}) async {
    return await locationRemoteDataSource.getLocation(lat: lat, lon: lon);
  }

  @override
  Future<RouteModel> getRouteEntity(
      {required LatLng start, required LatLng end}) async {
    return await routeRemoteDataSource.getRouteEntity(start: start, end: end);
  }

  @override
  Future<List<PlaceModel>> searchPlaces({required String query}) async {
    return await locationRemoteDataSource.searchPlaces(query: query);
  }
}
