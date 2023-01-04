import 'package:weather/domain/model/forecast_weather_model.dart';

class ForecastWeatherDTO extends ForecastWeatherModel {
  ForecastWeatherDTO({
    required num? lat,
    required num? lon,
    required String? timezone,
    required int? timezoneOffset,
    required CurrentDTO? current,
    required List<DailyDTO>? daily,
    required List<AlertsDTO>? alerts,
  }) : super(
            lat: lat,
            lon: lon,
            timezone: timezone,
            timezoneOffset: timezoneOffset,
            current: current,
            daily: daily,
            alerts: alerts);

  factory ForecastWeatherDTO.fromJson(Map<String, dynamic> json) {
    List<DailyDTO>? daily = [];
    if (json['daily'] != null) {
      json['daily'].forEach((v) {
        daily.add(DailyDTO.fromJson(v));
      });
    }

    List<AlertsDTO>? alerts = [];
    if (json['alerts'] != null) {
      json['alerts'].forEach((v) {
        alerts.add(AlertsDTO.fromJson(v));
      });
    }

    num? lat = json['lat'];
    num? lon = json['lon'];
    String? timezone = json['timezone'];
    int? timezoneOffset = json['timezone_offset'];
    CurrentDTO? currentDTO =
        json['current'] != null ? CurrentDTO.fromJson(json['current']) : null;

    return ForecastWeatherDTO(
        lat: lat,
        lon: lon,
        timezone: timezone,
        timezoneOffset: timezoneOffset,
        current: currentDTO,
        daily: daily,
        alerts: alerts);
  }
}

class AlertsDTO extends AlertsModel {

  AlertsDTO.fromJson(dynamic json) {
    senderName = json['sender_name'];
    event = json['event'];
    start = json['start'];
    end = json['end'];
    description = json['description'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }
}

class DailyDTO extends DailyModel {


  DailyDTO.fromJson(dynamic json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    temp = json['temp'] != null ? TempDTO.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? FeelsLikeDTO.fromJson(json['feels_like'])
        : null;

    pressure = json['pressure'];

    humidity = json['humidity'];
    dewPoint = json['dew_point'];

    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(WeatherDTO.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    rain = json['rain'];
    uvi = json['uvi'];
  }

}

class WeatherDTO extends WeatherModel {

  WeatherDTO.fromJson(dynamic json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class FeelsLikeDTO extends FeelsLikeModel {

  FeelsLikeDTO.fromJson(dynamic json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

}

class TempDTO extends TempModel {

  TempDTO.fromJson(dynamic json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

}

class CurrentDTO extends CurrentModel {

  CurrentDTO.fromJson(dynamic json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'];
    feelsLike = json['feels_like'];

    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];

    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    // windGust = json['wind_gust'] ?? 0;

    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(WeatherDTO.fromJson(v));
      });
    }
  }

}
