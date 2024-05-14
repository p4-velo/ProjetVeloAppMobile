class Localisation {
  final int id;
  final double latitude;
  final double longitude;
  final double? altitude;

  Localisation({required this.id, required this.latitude, required this.longitude, this.altitude});
}