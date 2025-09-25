import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_test/features/order/domain/usecases/create_order_use_case.dart';
import 'package:taxi_test/features/order/presentation/revierpod/providers/firebase_order_repository_provider.dart';

final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
  final repository = ref.watch(firebaseOrderRepositoryProvider); // حقن dependency
  return CreateOrderUseCase(repository);
});
