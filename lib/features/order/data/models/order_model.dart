// models/order_model.dart
import '../../domain/entities/order.dart';

import 'package:latlong2/latlong.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required  super.id,
    required  super.pickup,
    required super. dropOff,
    required super. status,
     super.driverLocation,
  });

  // Factory to create from Firebase document
  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    return OrderModel(
      id: id,
      pickup: LatLng(map['pickup']['lat'], map['pickup']['lon']),
      dropOff: LatLng(map['dropOff']['lat'], map['dropOff']['lon']),
      status: OrderStatus.values.firstWhere(
              (e) => e.toString() == 'OrderStatus.${map['status']}',
          orElse: () => OrderStatus.searching),
      driverLocation: map['driverLocation'] != null
          ? LatLng(map['driverLocation']['lat'], map['driverLocation']['lon'])
          : null,
    );
  }

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'pickup': {'lat': pickup.latitude, 'lon': pickup.longitude},
      'dropOff': {'lat': dropOff.latitude, 'lon': dropOff.longitude},
      'status': status.name,
      'driverLocation': driverLocation != null
          ? {'lat': driverLocation!.latitude, 'lon': driverLocation!.longitude}
          : null,
    };
  }
}
