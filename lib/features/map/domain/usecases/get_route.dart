
import 'package:latlong2/latlong.dart';

import '../entities/route.dart';
import '../repositories/location_repository.dart';

class GetRouteUseCase {
  final LocationRepository repository;
  GetRouteUseCase(this.repository);
  Future<Route> call({required LatLng start, required LatLng end}) async {
    return await repository.getRoute(start: start, end: end);
  }
}
