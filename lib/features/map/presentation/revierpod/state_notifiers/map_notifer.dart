// map_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_test/features/map/domain/usecases/search_location_use_case.dart';
import '../../../domain/entities/place.dart';
import '../../../domain/entities/user_location.dart';
import '../../../domain/usecases/get_current_location.dart';
import '../providers/get_current_location_provider.dart';
import '../providers/search_place_use_case_provider.dart';

class MapState {
  final AsyncValue<UserLocation> userLocation;
  final AsyncValue<List<Place>> searchResult;

  const MapState({
    this.userLocation = const AsyncValue.loading(),
    this.searchResult = const AsyncValue.data([]),
  });
  MapState copyWith({
    AsyncValue<UserLocation>? userLocation,
    AsyncValue<List<Place>>? searchResult,
  }) {
    return MapState(
      userLocation: userLocation ?? this.userLocation,
      searchResult: searchResult ?? this.searchResult,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  final GetCurrentLocationUseCase getCurrentLocation;
  final SearchPlaceUseCase searchPlaceUseCase;

  MapNotifier(this.getCurrentLocation, this.searchPlaceUseCase)
      : super(const MapState());
  Future<void> loadUserLocation({
    required double lat,
    required double lon,
  }) async {
    state = state.copyWith(userLocation: const AsyncValue.loading());
    // reset to loading before fetch
    try {
      final location = await getCurrentLocation.call(lat: lat, lon: lon);
      print("location in notifier${location.latitude}");
      state = state.copyWith(userLocation: AsyncValue.data(location));
    } catch (e, st) {
      state = state.copyWith(userLocation: AsyncValue.error(e, st));
    }
  }

  Future<void> searchPlaces({required String query}) async {
    state = state.copyWith(
        searchResult:
            const AsyncValue.loading()); // reset to loading before fetch
    try {
      final List<Place> places = await searchPlaceUseCase.call(query: query);
      state = state.copyWith(searchResult: AsyncValue.data(places));
    } catch (e, st) {
      state = state.copyWith(searchResult: AsyncValue.error(e, st));
    }
  }
}

final mapNotifierProvider = StateNotifierProvider<MapNotifier, MapState>((ref) {
  final getCurrentLocation = ref.watch(getCurrentLocationProvider);
  final searchPlace = ref.watch(searchPlaceUseCaseProvider);
  return MapNotifier(getCurrentLocation, searchPlace);
});
