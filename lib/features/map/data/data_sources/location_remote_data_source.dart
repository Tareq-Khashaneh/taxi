import 'package:dio/dio.dart';
import 'package:taxi_test/features/map/data/models/place_model.dart';
import 'package:taxi_test/features/map/data/models/user_location_model.dart';

import '../../../../core/constants/api_endpoint.dart';
import '../../../../core/utils/network/network_service.dart';

abstract class LocationRemoteDataSource {
  Future<UserLocationModel> getLocation(
      {required double lat, required double lon});
  Future<PlaceModel> searchPlace({required String query});
}

class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  final NetworkService _networkService;

  LocationRemoteDataSourceImpl(this._networkService);
  @override
  Future<UserLocationModel> getLocation(
      {required double lat, required double lon}) async {
    final response = await _networkService.request(
      endpoint: "${Api.baseNominatimUrl}${Api.reverse}",
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
  Future<PlaceModel> searchPlace({required String query}) async {
    final response = await _networkService.request(
      endpoint: "${Api.baseNominatimUrl}${Api.searchPlaces}",
      method: RequestMethod.get,
      queryParameters: {"q": query, "format": "json", "limit": 1},
    );
    print("response $response");
    List<PlaceModel> places = [];
    if (response.statusCode == 200) {
      for(var data in response.data){
         places.add(PlaceModel.fromJson(data));
      }
      return places[0];
      }
    throw DioException(
      response: response,
      requestOptions: response.requestOptions,
      type: DioExceptionType.badResponse,
    );
  }
}
