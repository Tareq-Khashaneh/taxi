class Place {
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final double lat;
  final double lon;
  final String placeClass;
  final String type;
  final int placeRank;
  final double importance;
  final String addresstype;
  final String name;
  final String displayName;
  final List<double> boundingbox;

  Place({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.placeClass,
    required this.type,
    required this.placeRank,
    required this.importance,
    required this.addresstype,
    required this.name,
    required this.displayName,
    required this.boundingbox,
  });
}