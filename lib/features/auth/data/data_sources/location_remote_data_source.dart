//
// import 'package:dio/dio.dart';
// import 'package:taxi_test/features/map/data/models/user_location_model.dart';
//
// import '../../../../core/constants/api_endpoint.dart';
// import '../../../../core/utils/network/network_service.dart';
//
// abstract class LocationRemoteDataSource {
//  Future<UserLocationModel> getLocation({required double lat,required double lon});
// }
//
// class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
//   final NetworkService _networkService;
//
//   LocationRemoteDataSourceImpl(this._networkService);
//   @override
//   Future<UserLocationModel> getLocation({required double lat,required double lon}) async {
//      final response =  await _networkService.request(endpoint: Api.reverseGeocode(lat, lon), method: RequestMethod.get);
//     if (response.statusCode == 200) {
//       return UserLocationModel.fromJson(response.data);
//       }
//       throw DioException(
//         response: response,
//         requestOptions: response.requestOptions,
//         type: DioExceptionType.badResponse,
//       );
//   }
// }