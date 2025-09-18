import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_test/core/shared/custom_field.dart';
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
  late String textMessage;
  late bool isConfirumPickPoint;
  LatLng? _tappedPoint;

  @override
  void initState() {
    super.initState();

    isConfirumPickPoint = false;
    _getUserLocation();
    searchController = TextEditingController();
    _mapController.mapEventStream.listen((event) {
      if (event is MapEventMoveEnd) {
        setState(() {
          _tappedPoint = event.camera.center; // point follows map center
        });
      }
    });
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

  Future<void> _searchPlace() async {
    if (searchController.text.isEmpty) return;
    print("searchResult ${searchController.text}}");
    await ref
        .read(mapNotifierProvider.notifier)
        .searchPlace(query: searchController.text);
    final searchResult =
        ref.read(mapNotifierProvider.select((s) => s.searchResult));
    print("searchResult $searchResult}");
    searchResult.whenData((place) {
      if (place != null) {
        _mapController.move(
            LatLng(place.lat, place.lon), _mapController.camera.zoom);
      }
    });
  }

  Future<void> _setPoint() async {
    final userLocation = ref.read(mapNotifierProvider).userLocation.maybeWhen(
          data: (location) => location, // <-- this is your UserLocation
          orElse: () => null,
        );

    if (userLocation != null) {
      setState(() {
        isConfirumPickPoint = true;
        _tappedPoint = LatLng(
          userLocation.latitude,
          userLocation.longitude,
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final userLocationAsync =
        ref.watch(mapNotifierProvider.select((s) => s.userLocation));
    ref.watch(mapNotifierProvider.select((s) => s.searchResult));

    final routeState = ref.watch(RouteNotifierProvider);
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
                  onTap: (tapPosition, point) async {
                  //   setState(() {
                  //     _tappedPoint = point;
                  //   });
                  //   final userLocation =
                  //       ref.read(mapNotifierProvider).userLocation.maybeWhen(
                  //             data: (loc) => loc,
                  //             orElse: () => null,
                  //           );
                  //
                  //
                  },
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
                      if (_tappedPoint != null)
                        Marker(
                          point: _tappedPoint!,
                          child: const Icon(Icons.location_pin,
                              color: Colors.red, size: 40),
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
              Positioned(
                  top: 40,
                  left: 15,
                  right: 15,
                  child: CustomField(
                    controller: searchController,
                    onSubmit: (_) => _searchPlace(),
                    suffixIcon: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                    hint: "Search here",
                    borderRadius: 30,
                  )),
            ],
          );
        },
      ),
      floatingActionButton:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          isConfirumPickPoint ?
          FloatingActionButton.extended(
            onPressed: _setPoint,
            label: Text("Confirm order"),
            icon: const Icon(Icons.location_on),
            backgroundColor: Colors.blue,
          ):
          FloatingActionButton.extended(
            onPressed: _setPoint,
            label: Text("Set pick-up point"),
            icon: const Icon(Icons.location_on),
            backgroundColor: Colors.blue,
          ),
          FloatingActionButton(
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
