class ForecastWeatherModel {
  num? lat;
  num? lon;
  String? timezone;
  int? timezoneOffset;
  CurrentModel? current;
  List<DailyModel>? daily;
  List<AlertsModel>? alerts;

  ForecastWeatherModel({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.daily,
    this.alerts,});
}

class AlertsModel {

  String? senderName;
  String? event;
  int? start;
  int? end;
  String? description;
  List<String>? tags;
  
  AlertsModel({
    this.senderName,
    this.event,
    this.start,
    this.end,
    this.description,
    this.tags,});

}

class DailyModel {
  DailyModel({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    this.uvi,});
  
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  num? moonPhase;
  TempModel? temp;
  FeelsLikeModel? feelsLike;
  int? pressure;
  int? humidity;
  num? dewPoint;
  num? windSpeed;
  int? windDeg;
  num? windGust;
  List<WeatherModel>? weather;
  int? clouds;
  num? pop;
  num? rain;
  num? uvi;
  
}

class WeatherModel {
  WeatherModel({
    this.id,
    this.main,
    this.description,
    this.icon,});

 
  int? id;
  String? main;
  String? description;
  String? icon;
}

class FeelsLikeModel {
  FeelsLikeModel({
    this.day,
    this.night,
    this.eve,
    this.morn,});

  num? day;
  num? night;
  num? eve;
  num? morn;

}

class TempModel {
  TempModel({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,});

  num? day;
  num? min;
  num? max;
  num? night;
  num? eve;
  num? morn;

}

class CurrentModel {
  CurrentModel({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,});

  int? dt;
  int? sunrise;
  int? sunset;
  num? temp;
  num? feelsLike;
  int? pressure;
  int? humidity;
  num? dewPoint;
  num? uvi;
  int? clouds;
  int? visibility;
  num? windSpeed;
  int? windDeg;
  num? windGust;
  List<WeatherModel>? weather;

}