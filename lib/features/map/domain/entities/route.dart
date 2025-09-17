import 'package:latlong2/latlong.dart';

class RouteEntity {
  final List<LatLng> points; // نقاط المسار الواقعي
  final double distance;     // المسافة بالمتر
  final double duration;     // الوقت المتوقع بالثواني أو الدقائق

  RouteEntity({required this.points, required this.distance, required this.duration});
}
