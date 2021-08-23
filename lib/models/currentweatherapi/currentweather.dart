class CurrentWeather {
  final lon;
  final lat;
  final List<WeatherShort> weather;
  final String base;
  final Main main;
  final visibility;
  final Wind wind;
  final dt;
  final System sys;
  final timezone;
  final String name;

  CurrentWeather(
    this.lon,
    this.lat,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.dt,
    this.sys,
    this.timezone,
    this.name,
  );

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      json['coord']['lon'],
      json['coord']['lat'],
      json['weather']
          .map<WeatherShort>((e) => WeatherShort.fromJson(e))
          .toList(),
      json['base'],
      Main.fromJson(json['main']),
      json['visibility'],
      Wind.fromJson(json['wind']),
      json['dt'],
      System.fromJson(json['sys']),
      json['timezone'],
      json['name'],
    );
  }
}

class System {
  final type;
  final id;
  final String country;
  final sunrise;
  final sunset;

  System(this.type, this.id, this.country, this.sunrise, this.sunset);

  factory System.fromJson(Map<String, dynamic> json) {
    return System(
      json['type'],
      json['id'],
      json['country'],
      json['sunrise'],
      json['sunset'],
    );
  }
}

class Wind {
  final speed;
  final degree;

  Wind(this.speed, this.degree);

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      json['speed'],
      json['deg'],
    );
  }
}

class WeatherShort {
  final id;
  final String main;
  final String description;
  final String icon;

  WeatherShort(this.id, this.main, this.description, this.icon);

  factory WeatherShort.fromJson(Map<String, dynamic> json) {
    return WeatherShort(
      json['id'],
      json['main'],
      json['description'],
      json['icon'],
    );
  }
}

class Main {
  final temp;
  final tempMin;
  final tempMax;
  final pressure;
  final humidity;

  Main(
    this.temp,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  );

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      json['temp'],
      json['temp_min'],
      json['temp_max'],
      json['pressure'],
      json['humidity'],
    );
  }
}
