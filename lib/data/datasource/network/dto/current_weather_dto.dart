import 'package:weather/domain/model/current_weather_model.dart';

class CurrentWeatherDTO extends CurrentWeatherModel{

  CurrentWeatherDTO({
    required CoordDTO? coord,
    required List<WeatherDTO>? weather,
    required String? base,
    required MainDTO? main,
    required int? visibility,
    required WindDTO? wind,
    required RainDTO? rain,
    required CloudsDTO? clouds,
    required int? dt,
    required SysDTO? sys,
    required int? timezone,
    required int? id,
    required String? name,
    required int? cod}):super(coord: coord, weather: weather,
      base: base,
      main: main,
      visibility: visibility,
      wind: wind,
      rain: rain,
      clouds: clouds,
      dt: dt,
      sys: sys,
      timezone: timezone,
      id: id,
      name: name,
      cod: cod);

  factory CurrentWeatherDTO.fromJson(Map<String, dynamic> json) {
    CoordDTO? coord = json['coord'] != null ? CoordDTO.fromJson(json['coord']) : null;
    List<WeatherDTO>? weather = <WeatherDTO>[];
    if (json['weather'] != null) {
      json['weather'].forEach((v) {
        weather.add(WeatherDTO.fromJson(v));
      });
    }
    String? base = json['base'];
    MainDTO? main = json['main'] != null ? MainDTO.fromJson(json['main']) : null;
    int? visibility = json['visibility'];
    WindDTO? windDTO = json['wind'] != null ? WindDTO.fromJson(json['wind']) : null;
    RainDTO? rainDTO = json['rain'] != null ? RainDTO.fromJson(json['rain']) : null;
    CloudsDTO? clouds = json['clouds'] != null ? CloudsDTO.fromJson(json['clouds']) : null;
    int? dt = json['dt'];
    SysDTO? sys = json['sys'] != null ? SysDTO.fromJson(json['sys']) : null;
    int? timezone = json['timezone'];
    int? id = json['id'];
    String? name = json['name'];
    int? cod = json['cod'];

    return CurrentWeatherDTO(coord: coord,
        weather: weather,
        base: base,
        main: main,
        visibility: visibility,
        wind: windDTO,
        rain: rainDTO,
        clouds: clouds,
        dt: dt,
        sys: sys,
        timezone: timezone,
        id: id,
        name: name,
        cod: cod);
  }
}

class CoordDTO extends CoordModel{

  CoordDTO.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }
}

class WeatherDTO extends WeatherModel {

  WeatherDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class MainDTO extends MainModel {

  MainDTO.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }
}

class WindDTO extends WindModel{

  WindDTO.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }
}

class RainDTO extends RainModel{

  RainDTO.fromJson(Map<String, dynamic> json) {
    d1h = json['1h'];
  }
}

class CloudsDTO extends CloudsModel{

  CloudsDTO.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class SysDTO extends SysModel{

  SysDTO.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}
