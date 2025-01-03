class Localisation {
  final int id;
  final double latitude;
  final double longitude;
  final double? altitude;

  Localisation({required this.id, required this.latitude, required this.longitude, this.altitude});

  factory Localisation.fromJson(List<dynamic> coordinates, int id) {
    return Localisation(
      id: id,
      latitude: coordinates[1],
      longitude: coordinates[0],
      altitude: coordinates.length > 2 ? coordinates[2] : null,
    );
  }
}