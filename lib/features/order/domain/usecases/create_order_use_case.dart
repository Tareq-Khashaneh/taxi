
import 'package:taxi_test/features/order/domain/entities/order.dart';
import 'package:taxi_test/features/order/domain/repositories/order_repository.dart';


class CreateOrderUseCase {
  final OrderRepository repository;
  CreateOrderUseCase(this.repository);
  Future<OrderEntity> call({required OrderEntity order})async{
    return await repository.createOrder(order);
  }
}
