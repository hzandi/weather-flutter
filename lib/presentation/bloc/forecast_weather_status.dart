import 'package:flutter/material.dart';
import 'package:weather/domain/model/forecast_weather_model.dart';

@immutable
abstract class ForecastWeatherStatus {

}

class ForecastWeatherLoadingStatus extends ForecastWeatherStatus {

}

class ForecastWeatherLoadedStatus extends ForecastWeatherStatus {
  final ForecastWeatherModel forecastWeatherModel;
  ForecastWeatherLoadedStatus(this.forecastWeatherModel);
}

class ForecastWeatherErrorStatus extends ForecastWeatherStatus {
  final String message;
  ForecastWeatherErrorStatus(this.message);
}