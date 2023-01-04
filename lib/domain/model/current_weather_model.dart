import 'package:equatable/equatable.dart';

class CurrentWeatherModel extends Equatable {
  final CoordModel? coord;
  final List<WeatherModel?>? weather;
  final String? base;
  final MainModel? main;
  final int? visibility;
  final WindModel? wind;
  final RainModel? rain;
  final CloudsModel? clouds;
  final int? dt;
  final SysModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  const CurrentWeatherModel(
      {required this.coord,
      required this.weather,
      required this.base,
      required this.main,
      required this.visibility,
      required this.wind,
      required this.rain,
      required this.clouds,
      required this.dt,
      required this.sys,
      required this.timezone,
      required this.id,
      required this.name,
      required this.cod});

  @override
  List<Object?> get props => [
        coord,
        weather,
        base,
        main,
        visibility,
        wind,
        rain,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod
      ];

  @override
  bool? get stringify => true;
}

class CoordModel {
  num? lon;
  num? lat;

  CoordModel({this.lon,  this.lat});
}

class WeatherModel {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherModel({ this.id,  this.main,  this.description,  this.icon});

}

class MainModel {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  int? pressure;
  int? humidity;

  MainModel({ this.temp,  this.feelsLike,  this.tempMin,  this.tempMax,
       this.pressure,  this.humidity});
}

class WindModel {
  num? speed;
  int? deg;
  num? gust;

  WindModel({ this.speed,  this.deg,  this.gust});
}

class RainModel {
  num? d1h;

  RainModel({ this.d1h});
}

class CloudsModel {
  int? all;

  CloudsModel({ this.all});
}

class SysModel {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  SysModel({ this.type,  this.id,  this.country,  this.sunrise,  this.sunset});
}
