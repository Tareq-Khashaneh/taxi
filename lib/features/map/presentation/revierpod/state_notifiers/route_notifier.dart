// RouteEntity_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../domain/entities/route.dart';
import '../../../domain/usecases/get_route.dart';
import '../providers/get_route_provider.dart';
class RouteEntityNotifier extends StateNotifier<AsyncValue<RouteEntity>> {
  final GetRouteEntityUseCase getRouteEntityUseCase;
  RouteEntityNotifier(this.getRouteEntityUseCase) : super(const AsyncValue.loading());

  Future<void> getRouteEntity(
      {required startLat,
      required startLon,
      required endLat,
      required endLon}) async {
    try {

      final start = LatLng(startLat, startLon);
      final end = LatLng(endLat, endLon);
      final RouteEntity =
          await getRouteEntityUseCase.call(start: start,end: end, );
      state = AsyncValue.data(RouteEntity);
      print("RouteEntity $RouteEntity");
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// provider
final RouteNotifierProvider =
    StateNotifierProvider<RouteEntityNotifier, AsyncValue<RouteEntity>>((ref) {
  final useCase = ref.watch(getRouteProvider);
  return RouteEntityNotifier(useCase);
});
