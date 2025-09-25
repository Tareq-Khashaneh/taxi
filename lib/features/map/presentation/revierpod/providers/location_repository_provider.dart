import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/location_repository_impl.dart';
import '../../../domain/repositories/location_repository.dart';
import 'remote_data_source_provider.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final locationRemoteDataSource = ref.watch(locationRemoteDataSourceProvider);
  final routingRemoteDataSource = ref.watch(routingRemoteDataSourceProvider);
  return LocationRepositoryImpl(locationRemoteDataSource,routingRemoteDataSource);
});