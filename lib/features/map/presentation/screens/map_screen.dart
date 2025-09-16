import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../revierpod/state_notifiers/map_notifer.dart';
import '../revierpod/state_notifiers/route_notifier.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();

  LatLng? _tappedPoint;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getCurrentPosition();

      // Trigger Riverpod use case via MapNotifier
      ref.read(mapNotifierProvider.notifier).loadUserLocation(
            lat: position.latitude,
            lon: position.longitude,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapNotifierProvider);
    final routeState = ref.watch(routeNotifierProvider);
    return Scaffold(
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (userLocation) {
          final LatLng userLatLng =
              LatLng(userLocation.latitude, userLocation.longitude);

          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: userLatLng,
              initialZoom: 14,
              onTap: (tapPosition, point) async {
                setState(() {
                  _tappedPoint = point;
                });
                final userLocation = ref.read(mapNotifierProvider).maybeWhen(
                      data: (loc) => loc,
                      orElse: () => null,
                    );

                if (userLocation != null) {
                  // Trigger RouteNotifier
                  await ref.read(routeNotifierProvider.notifier).loadRoute(
                        startLat: userLocation.latitude,
                        startLon: userLocation.longitude,
                        endLat: point.latitude,
                        endLon: point.longitude,
                      );
                }
              },
            ),
            children: [
              // Map tiles
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.taxi_test',
              ),

              // Markers
              MarkerLayer(
                markers: [
                  Marker(
                    point: userLatLng,
                    child: const Icon(Icons.my_location,
                        color: Colors.blue, size: 35),
                  ),
                  if (_tappedPoint != null)
                    Marker(
                      point: _tappedPoint!,
                      child: const Icon(Icons.location_pin,
                          color: Colors.red, size: 40),
                    ),
                ],
              ),

              // Polyline (user ↔ tapped point)
              if (routeState is AsyncData<Route>)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeState.value?.points ?? [],
                      color: Colors.green,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
