import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_test/features/map/presentation/screens/set_pick_up_point_screen.dart';
import '../../domain/entities/route.dart';
import '../revierpod/state_notifiers/map_notifer.dart';
import '../revierpod/state_notifiers/route_notifier.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  late TextEditingController searchController;
  late Position position;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _goToMyLocation() async {
    try {
      position = await Geolocator.getCurrentPosition();

      // بس حرك الماب، لا تعمل setState ولا تغير الـ provider
      _mapController.move(
        LatLng(position.latitude, position.longitude),
        _mapController.camera.zoom, // نفس الزووم الحالي
      );
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      position = await Geolocator.getCurrentPosition();
      ref.read(mapNotifierProvider.notifier).loadUserLocation(
            lat: position.latitude,
            lon: position.longitude,
          );
    }
  }

  double calculatePrice(double distanceMeters) {
    // Example: base fare + per km
    const baseFare = 3.0; // $
    const pricePerKm = 1.2; // $ per km

    final km = distanceMeters / 1000;
    return baseFare + (km * pricePerKm);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<RouteEntity>>(routeNotifierProvider,
        (previous, next) {
      next.whenData((route) {
        if (route.points.isNotEmpty) {
          final bounds = LatLngBounds.fromPoints(route.points);

          _mapController.fitCamera(
            CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(50)),
          );
        }
      });
    });
    final userLocationAsync =
        ref.watch(mapNotifierProvider.select((s) => s.userLocation));
    ref.watch(mapNotifierProvider.select((s) => s.searchResult));

    final routeState = ref.watch(routeNotifierProvider);
    return Scaffold(
      body: userLocationAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (userLocation) {
          final LatLng userLatLng =
              LatLng(userLocation.latitude, userLocation.longitude);
          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: userLatLng,
                  initialZoom: 16,
                ),
                children: [
                  // Map tiles
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.taxi_test',
                  ),

                  // Markers
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: userLatLng,
                        child: const Icon(Icons.circle,
                            color: Colors.blue, size: 35),
                      ),
                    ],
                  ),

                  // Polyline (user ↔ tapped point)
                  if (routeState is AsyncData<RouteEntity>)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routeState.value.points,
                          color: Colors.green,
                          strokeWidth: 4.0,
                        ),
                      ],
                    ),
                ],
              ),
              if (routeState is AsyncData<RouteEntity>)
                Positioned(
                  bottom: 80,
                  left: 20,
                  right: 20,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Builder(builder: (_) {
                        final route = routeState.value;
                        final km = (route.distance / 1000).toStringAsFixed(2);
                        final durationMin =
                            (route.duration / 60).toStringAsFixed(0);
                        final price =
                            calculatePrice(route.distance).toStringAsFixed(2);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Distance: $km km"),
                            Text("Duration: $durationMin min"),
                            Text("Price: \$$price"),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SetPickUpPointScreen())),
            label: const Text("Set pick-up point"),
            icon: const Icon(Icons.location_on),
            backgroundColor: Colors.blue,
          ),
          FloatingActionButton(
            heroTag: "goToLocationBtn",
            onPressed: _goToMyLocation,
            child: const Icon(
              Icons.gps_fixed,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
