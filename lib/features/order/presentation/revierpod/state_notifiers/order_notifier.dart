// map_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_test/features/order/domain/usecases/create_order_use_case.dart';
import '../../../domain/entities/order.dart';
import '../providers/create_order__use_case_provider.dart';

class OrderState  {
  final bool isLoading;
  final OrderEntity? order;
  final String? error;

  const OrderState({this.isLoading = false, this.order, this.error});

  OrderState copyWith({
    bool? isLoading,
    OrderEntity? order,
    String? error,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      order: order ?? this.order,
      error: error ?? this.error,
    );
  }

  // @override
  // List<Object?> get props => [isLoading, order, error];
}
class OrderNotifier extends StateNotifier<OrderState> {
  final CreateOrderUseCase createOrderUseCase;

  OrderNotifier( this.createOrderUseCase) : super(const OrderState());

  Future<void> createOrder(OrderEntity order) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final createdOrder = await createOrderUseCase.call(order: order);
      state = state.copyWith(isLoading: false, order: createdOrder);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // void updateDriverLocation(LatLng location) {
  //   state = state.copyWith(driverLocation: location, isDriverAssigned: true);
  // }
}


final orderNotifierProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  final createOrderUseCase = ref.watch(createOrderUseCaseProvider);
  return OrderNotifier(createOrderUseCase,);
});
