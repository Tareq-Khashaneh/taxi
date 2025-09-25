import '../entities/place.dart';
import '../repositories/location_repository.dart';

class SearchPlaceUseCase {
  final LocationRepository repository;
  SearchPlaceUseCase(this.repository);
  Future<List<Place>> call({required String query}) async {
    return await repository.searchPlaces(query: query);
  }
}
