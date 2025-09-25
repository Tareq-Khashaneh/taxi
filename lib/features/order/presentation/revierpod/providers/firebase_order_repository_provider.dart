
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_test/features/order/data/repositories/firebase_order_repository_impl.dart';
import 'package:taxi_test/features/order/presentation/revierpod/providers/remote_data_source_provider.dart';

final firebaseOrderRepositoryProvider =
    Provider<FirebaseOrderRepository>((ref) {
  final orderRemoteDataSource = ref.watch(orderRemoteDataSourceProvider);
  return FirebaseOrderRepository(orderRemoteDataSource);
});
