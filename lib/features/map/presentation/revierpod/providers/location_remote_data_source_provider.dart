import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_test/features/map/data/data_sources/routing_remote_data_source.dart';

import '../../../../../core/utils/network/network_service_provider.dart';
import '../../../../auth/data/data_sources/location_remote_data_source.dart';
import '../../../data/data_sources/location_remote_data_source.dart';

final locationRemoteDataSourceProvider =
Provider<LocationRemoteDataSource>((ref) {
  final networkService = ref.watch(networkServiceDioProvider);
  return LocationRemoteDataSourceImpl(networkService);
});

final routingRemoteDataSourceProvider =
Provider<RouteRemoteDataSource>((ref) {
  final networkService = ref.watch(networkServiceDioProvider);
  return RoutingRemoteDataSourceImpl(networkService);
});
