import 'package:flutter/cupertino.dart';
import '../../domain/model/current_weather_model.dart';

@immutable
abstract class CurrentWeatherStatus {

}

class CurrentWeatherLoadingStatus extends CurrentWeatherStatus {

}

class CurrentWeatherLoadedStatus extends CurrentWeatherStatus {
  final CurrentWeatherModel currentWeatherModel;
  CurrentWeatherLoadedStatus(this.currentWeatherModel);
}

class CurrentWeatherErrorStatus extends CurrentWeatherStatus {
  final String message;
  CurrentWeatherErrorStatus(this.message);
}