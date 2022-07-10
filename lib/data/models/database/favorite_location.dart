import 'dart:convert';

FavoriteLocation favoriteLocationFromJson(String str) {
  final jsonData = json.decode(str);
  return FavoriteLocation.fromMap(jsonData);
}

String favoriteLocationToJson(FavoriteLocation data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class FavoriteLocation {
  late int id;
  String cityname;
  double latitude;
  double longitude;

  static int getId(double lat, double lng) {
    int _lat = lat.round() + 180;
    int _lng = lng.round() + 180;
    return _lat * 1000 + _lng;
  }

  FavoriteLocation({
    this.cityname = '_unknown_',
    required this.latitude,
    required this.longitude,
  }) : this.id = getId(latitude, longitude);

  factory FavoriteLocation.fromMap(Map<String, dynamic> json) =>
      new FavoriteLocation(
        cityname: json["cityname"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cityname": cityname,
        "latitude": latitude,
        "longitude": longitude,
      };
}
