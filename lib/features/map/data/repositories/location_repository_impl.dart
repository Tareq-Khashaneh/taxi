

import 'package:latlong2/latlong.dart';
import 'package:taxi_test/features/map/data/data_sources/location_remote_data_source.dart';
import 'package:taxi_test/features/map/domain/entities/route.dart';
import 'package:taxi_test/features/map/domain/entities/user_location.dart';
import 'package:taxi_test/features/map/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository{
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl(this.locationRemoteDataSource);
  @override
  Future<UserLocation> getCurrentLocation({required double lat,required double lon}) async{
       return await locationRemoteDataSource.getLocation(lat: lat, lon: lon);
  }

  @override
  Future<Route> getRoute({required LatLng start, required LatLng end})async {
  return await locationRemoteDataSource.getRoute(start: start, end: end);

  }

}