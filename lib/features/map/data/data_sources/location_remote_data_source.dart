import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxi_test/features/map/data/models/user_location_model.dart';

import '../../../../core/constants/api_endpoint.dart';
import '../../../../core/utils/network/network_service.dart';
import '../models/route_model.dart';

abstract class LocationRemoteDataSource {
  Future<UserLocationModel> getLocation(
      {required double lat, required double lon});
  Future<RouteModel> getRoute({
    required LatLng start,
    required LatLng end,
  });
}

class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  final NetworkService _networkService;

  LocationRemoteDataSourceImpl(this._networkService);
  @override
  Future<UserLocationModel> getLocation(
      {required double lat, required double lon}) async {
    final response = await _networkService.request(
      endpoint: Api.getLocation,
      method: RequestMethod.get,
      queryParameters: {"lat": lat, "lon": lon, "format": "json"},
    );
    print("response $response");
    if (response.statusCode == 200) {
      return UserLocationModel.fromJson(response.data);
    }

    throw DioException(
      response: response,
      requestOptions: response.requestOptions,
      type: DioExceptionType.badResponse,
    );
  }

  @override
  Future<RouteModel> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    final query = {
      "overview": "full",
      "geometries": "geojson",
    };
    final url =
        "/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}";

    final response = await _networkService.request(
      endpoint: url,
      method: RequestMethod.get,
      queryParameters: query,
    );
    print("response $response");
    if (response.statusCode == 200) {
      return RouteModel.fromJson(response.data);
    }
    throw DioException(
      response: response,
      requestOptions: response.requestOptions,
      type: DioExceptionType.badResponse,
    );
  }
}
