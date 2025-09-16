
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/get_current_location.dart';
import 'location_repository_provider.dart';

final getCurrentLocationProvider = Provider<GetCurrentLocationUseCase>((ref) {
  final repository = ref.watch(locationRepositoryProvider); // حقن dependency
  return GetCurrentLocationUseCase(repository);
});
