import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network_service.dart';

final networkServiceDioProvider = Provider<NetworkService>((ref) {
  return NetworkServiceDio(); // هنا يكون Dio داخل NetworkService
});
