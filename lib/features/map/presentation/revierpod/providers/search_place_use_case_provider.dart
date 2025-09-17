
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_test/features/map/domain/usecases/search_location_use_case.dart';
import '../../../domain/usecases/get_current_location.dart';
import 'location_repository_provider.dart';

final searchPlaceUseCaseProvider = Provider<SearchPlaceUseCase>((ref) {
  final repository = ref.watch(locationRepositoryProvider); // حقن dependency
  return SearchPlaceUseCase(repository);
});
