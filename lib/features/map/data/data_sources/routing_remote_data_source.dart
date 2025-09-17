import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/api_endpoint.dart';
import '../../../../core/utils/network/network_service.dart';
import '../models/route_model.dart';


abstract class RouteRemoteDataSource {
  Future<RouteModel> getRouteEntity({
    required LatLng start,
    required LatLng end,
  });
}

class RoutingRemoteDataSourceImpl implements RouteRemoteDataSource {
  final NetworkService _networkService;

  RoutingRemoteDataSourceImpl(this._networkService);

  @override
  Future<RouteModel> getRouteEntity({
    required LatLng start,
    required LatLng end,
  }) async {
    final query = {
      "overview": "full",
      "geometries": "geojson",
    };
    final url =
        "${Api.baseRoutingUrl}/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}";

    final response = await _networkService.request(
      endpoint: url,
      method: RequestMethod.get,
      queryParameters: query,
    );
    print("response in RouteEntity $response");
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
