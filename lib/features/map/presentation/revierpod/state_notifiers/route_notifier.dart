// RouteEntity_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../domain/entities/route.dart';
import '../../../domain/usecases/get_route.dart';
import '../providers/get_route_provider.dart';

class RouteNotifier extends StateNotifier<AsyncValue<RouteEntity>> {
  final GetRouteUseCase getRouteUseCase;
  RouteNotifier(this.getRouteUseCase) : super(const AsyncValue.loading());

  Future<void> getRoute(
      {required startLat,
      required startLon,
      required endLat,
      required endLon}) async {
    try {
      final start = LatLng(startLat, startLon);
      final end = LatLng(endLat, endLon);
      final route = await getRouteUseCase.call(
        start: start,
        end: end,
      );
      state = AsyncValue.data(route);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// provider
final routeNotifierProvider =
    StateNotifierProvider<RouteNotifier, AsyncValue<RouteEntity>>((ref) {
  final useCase = ref.watch(getRouteProvider);
  return RouteNotifier(useCase);
});
