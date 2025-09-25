import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_test/features/order/data/data_sources/order_remote_data_source.dart';

final orderRemoteDataSourceProvider = Provider<OrderRemoteDataSource>((ref) {
  final fireStore = FirebaseFirestore.instance;
  return OrderRemoteDataSourceImpl(fireStore);
});
