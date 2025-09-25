
import 'package:latlong2/latlong.dart';

import '../entities/order.dart';

abstract class OrderRepository {
  Future<OrderEntity> createOrder(OrderEntity order);
  Stream<OrderEntity> watchOrder(String orderId);
  Future<void> updateDriverLocation(String orderId, LatLng driverLocation);
}
