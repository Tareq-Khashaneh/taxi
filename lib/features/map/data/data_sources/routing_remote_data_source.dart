import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxi_test/features/map/data/models/user_location_model.dart';

import '../../../../core/constants/api_endpoint.dart';
import '../../../../core/utils/network/network_service.dart';
import '../models/route_model.dart';

abstract class RouteRemoteDataSource {
  Future<RouteModel> getRoute({
    required LatLng start,
    required LatLng end,
  });
}

class RoutingRemoteDataSourceImpl implements RouteRemoteDataSource {
  final NetworkService _networkService;

  RoutingRemoteDataSourceImpl(this._networkService);

  @override
  Future<RouteModel> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    final query = {
      "overview": "full",
      "geometries": "geojson",
    };
    print("start $start");
    final url =
        "https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}";
    if(_networkService is NetworkServiceDio ){
      print("base ${_networkService.dio.options.baseUrl}");

    }
    final response = await _networkService.request(
      endpoint: url,
      method: RequestMethod.get,
      queryParameters: query,
    );
    print("response in route $response");
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
