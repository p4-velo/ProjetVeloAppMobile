class FavoritePlace {
  final int id;
  final String latitude;
  final String longitude;
  final String altitude;
  final String title;
  final String city;
  final String postalCode;
  final String address;
  final String name;
  final int userId;

  FavoritePlace({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.title,
    required this.city,
    required this.postalCode,
    required this.address,
    required this.name,
    required this.userId,
  });

  factory FavoritePlace.fromJson(Map<String, dynamic> json) {
    return FavoritePlace(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      altitude: json['altitude'],
      title: json['title'],
      city: json['city'],
      postalCode: json['postalCode'],
      address: json['adress'],
      name: json['name'],
      userId: json['userId'],
    );
  }
}
