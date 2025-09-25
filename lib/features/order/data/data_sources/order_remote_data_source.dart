import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxi_test/features/order/data/models/order_model.dart';

import '../../domain/entities/order.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(OrderModel order);
  Stream<OrderModel> watchOrder(String orderId);
  Future<void> updateDriverLocation(
      String orderId, LatLng driverLocation);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore fireStore;

  OrderRemoteDataSourceImpl(this.fireStore);

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    await fireStore.collection('orders').doc(order.id).set(order.toMap());
    return order;
  }
  @override
  Stream<OrderModel> watchOrder(String orderId) {
    return fireStore.collection('orders').doc(orderId).snapshots().map((doc) {
      final data = doc.data()!;
      return OrderModel.fromMap(orderId, data);
    });
  }
  @override
  Future<void> updateDriverLocation(
      String orderId, LatLng driverLocation) async {
    await fireStore.collection('orders').doc(orderId).update({
      'driverLocation': {
        'lat': driverLocation.latitude,
        'lon': driverLocation.longitude
      },
      'status': OrderStatus.driverAssigned.name,
    });
  }
}
