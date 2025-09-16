// map_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/user_location.dart';
import '../../../domain/usecases/get_current_location.dart';
import '../providers/get_current_location_provider.dart';

class MapNotifier extends StateNotifier<AsyncValue<UserLocation>> {
  final GetCurrentLocationUseCase getCurrentLocation;

  MapNotifier(this.getCurrentLocation) : super(const AsyncValue.loading());
  Future<void> loadUserLocation({
    required double lat,
    required double lon,
  }) async {
    state = const AsyncValue.loading(); // reset to loading before fetch
    try {
      final location = await getCurrentLocation.call(lat: lat, lon: lon);
      print("location in notifier${location.latitude}");
      state = AsyncValue.data(location);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
final mapNotifierProvider =
StateNotifierProvider<MapNotifier, AsyncValue<UserLocation>>((ref) {
  final useCase = ref.watch(getCurrentLocationProvider);
  return MapNotifier(useCase);
});
