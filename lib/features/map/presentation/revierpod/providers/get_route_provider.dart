// get_RouteEntity_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/get_route.dart';
import 'location_repository_provider.dart';

final getRouteProvider = Provider<GetRouteEntityUseCase>((ref) {
  final repository = ref.watch(locationRepositoryProvider);
  return GetRouteEntityUseCase(repository);
});
