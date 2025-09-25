// entities/order.dart
import 'package:latlong2/latlong.dart';

enum OrderStatus { searching, driverAssigned, onTrip, completed }

class OrderEntity {
  final String id;
  final LatLng pickup;
  final LatLng dropOff;
  final OrderStatus status;
  final LatLng? driverLocation;

  OrderEntity({
    required this.id,
    required this.pickup,
    required this.dropOff,
    required this.status,
    this.driverLocation,
  });

  OrderEntity copyWith({
    String? id,
    LatLng? pickup,
    LatLng? dropOff,
    OrderStatus? status,
    LatLng? driverLocation,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      pickup: pickup ?? this.pickup,
      dropOff: dropOff ?? this.dropOff,
      status: status ?? this.status,
      driverLocation: driverLocation ?? this.driverLocation,
    );
  }
}
