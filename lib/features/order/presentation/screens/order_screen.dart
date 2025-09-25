// order_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../map/presentation/screens/map_screen.dart';
import '../../domain/entities/order.dart';
import '../revierpod/state_notifiers/order_notifier.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Order")),
      body: Column(
        children: [
          // Reuse MapScreen here
          const Expanded(child: MapScreen()),

          // Order details
          if (state.order?.status == OrderStatus.searching)
            ElevatedButton(
              onPressed: () {
                ref.read(orderNotifierProvider.notifier).confirmOrder();
              },
              child: const Text("Confirm Order"),
            ),

          if (order.status == OrderStatus.lookingForDriver)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
