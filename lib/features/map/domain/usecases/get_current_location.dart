// lib/features/map/domain/usecases/get_current_location.dart

import '../entities/user_location.dart';
import '../repositories/location_repository.dart';

 class GetCurrentLocationUseCase {
  final LocationRepository repository;
  GetCurrentLocationUseCase(this.repository);
  Future<UserLocation> call({required double lat,required double lon})async{
    return await repository.getCurrentLocation(lat:  lat, lon:  lon);
  }
}
