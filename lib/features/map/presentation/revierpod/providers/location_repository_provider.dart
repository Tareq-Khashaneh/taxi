import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/location_repository_impl.dart';
import '../../../domain/repositories/location_repository.dart';
import 'location_remote_data_source_provider.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final remoteDataSource = ref.watch(locationRemoteDataSourceProvider);
  return LocationRepositoryImpl(remoteDataSource);
});