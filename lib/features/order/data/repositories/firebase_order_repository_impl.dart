import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxi_test/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:taxi_test/features/order/data/models/order_model.dart';

import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

class FirebaseOrderRepository implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;
  FirebaseOrderRepository(this.orderRemoteDataSource);

  @override
  Future<OrderModel> createOrder(OrderEntity order) async {
    final orderModel = OrderModel(
      id: order.id,
      pickup: order.pickup,
      dropOff: order.dropOff,
      status: order.status,
      driverLocation: order.driverLocation,
    );
    return orderRemoteDataSource.createOrder(orderModel);
  }

  @override
  Stream<OrderModel> watchOrder(String orderId) {
    return orderRemoteDataSource.watchOrder(orderId);
  }

  @override
  Future<void> updateDriverLocation(
      String orderId, LatLng driverLocation) async {
    await orderRemoteDataSource.updateDriverLocation(orderId, driverLocation);
  }
}
