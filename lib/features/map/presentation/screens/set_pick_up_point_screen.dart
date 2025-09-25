import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/shared/custom_field.dart';
import '../revierpod/state_notifiers/map_notifer.dart';
import '../revierpod/state_notifiers/route_notifier.dart';

class SetPickUpPointScreen extends ConsumerStatefulWidget {
  const SetPickUpPointScreen({super.key});

  @override
  ConsumerState<SetPickUpPointScreen> createState() => _SetPickUpPointState();
}

class _SetPickUpPointState extends ConsumerState<SetPickUpPointScreen> {
  final MapController _mapController = MapController();
  late TextEditingController searchController;
  late Position position;
  LatLng? _pickUpPoint;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
    searchController = TextEditingController();
    _mapController.mapEventStream.listen((event) {
      if (event is MapEventMoveEnd) {
        setState(() {
          _pickUpPoint = event.camera.center; // point follows map center
        });
      }
    });
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
        .searchPlaces(query: searchController.text);
    final searchResult =
        ref.read(mapNotifierProvider.select((s) => s.searchResult));
    print("searchResult $searchResult}");
    searchResult.whenData((places) {

      if (places.isNotEmpty) {
        final place = places[0];
        _mapController.move(
            LatLng(place.lat, place.lon), _mapController.camera.zoom);
        setState(() {
          _pickUpPoint = _mapController.camera.center; // point follows map center
        });
         }
    });

  }

  // Future<void> _setPoint() async {
  //   final userLocation = ref.read(mapNotifierProvider).userLocation.maybeWhen(
  //         data: (location) => location, // <-- this is your UserLocation
  //         orElse: () => null,
  //       );
  //
  //   if (userLocation != null) {
  //     setState(() {
  //       isSetPoint = false;
  //       _pickUpPoint = LatLng(
  //         userLocation.latitude,
  //         userLocation.longitude,
  //       );
  //     });
  //   }
  // }

  Future<void> _confirm() async {
    final userLocation = ref.read(mapNotifierProvider).userLocation.maybeWhen(
          data: (loc) => loc,
          orElse: () => null,
        );
    await ref.read(routeNotifierProvider.notifier).getRoute(
        startLat: userLocation?.latitude,
        startLon: userLocation?.longitude,
        endLat: _pickUpPoint?.latitude,
        endLon: _pickUpPoint?.longitude);
  }


  @override
  Widget build(BuildContext context) {
    final userLocationAsync =
        ref.watch(mapNotifierProvider.select((s) => s.userLocation));
    ref.watch(mapNotifierProvider.select((s) => s.searchResult));
    ref.read(mapNotifierProvider).userLocation.maybeWhen(
          data: (loc) => loc,
          orElse: () => null,
        );

    return Scaffold(
      body: userLocationAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (userLocation) {
          final LatLng userLatLng =
              LatLng(userLocation.latitude, userLocation.longitude);
          _pickUpPoint ??= userLatLng;

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _pickUpPoint!,
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
                      if (_pickUpPoint != null)
                        Marker(
                          point: _pickUpPoint!,
                          child: const Icon(Icons.location_pin,
                              color: Colors.red, size: 40),
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
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "setPickupBtn",
        onPressed: () {
          _confirm();
          Navigator.pop(context);
        },
        label: const Text("Confirm order"),
        icon: const Icon(Icons.location_on),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
