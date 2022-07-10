import 'dart:convert';

RecentSearch recentSearchFromJson(String str) {
  final jsonData = json.decode(str);
  return RecentSearch.fromMap(jsonData);
}

String recentSearchToJson(RecentSearch data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class RecentSearch {
  int id;
  String cityname;

  RecentSearch({
    required this.id,
    required this.cityname,
  });

  factory RecentSearch.fromMap(Map<String, dynamic> json) => new RecentSearch(
        id: json["id"],
        cityname: json["cityname"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cityname": cityname,
      };
}
