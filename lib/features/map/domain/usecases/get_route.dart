
import 'package:latlong2/latlong.dart';
import '../entities/route.dart';
import '../repositories/location_repository.dart';

class GetRouteEntityUseCase {
  final LocationRepository repository;
  GetRouteEntityUseCase(this.repository);
  Future<RouteEntity> call({required LatLng start, required LatLng end}) async {
    return await repository.getRouteEntity(start: start, end: end);
  }
}
