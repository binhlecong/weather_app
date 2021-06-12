import 'package:http/http.dart' as http;

class WeatherAPI {
  final lat;
  final lon;
  final apikey = '618d67fe3ad2a8af158022fff834119c';
  WeatherAPI({this.lat, this.lon});

  Future<String> apiCall() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apikey'));

    if (response.statusCode == 200)
      return response.body.toString();
    else
      return 'Failed';
  }
}
