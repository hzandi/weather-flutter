part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class CurrentWeatherEvent extends HomeEvent {
  final String cityName;
  CurrentWeatherEvent(this.cityName);
}

class ForecastWeatherEvent extends HomeEvent {
  final double lat;
  final double lon;
  ForecastWeatherEvent(this.lat, this.lon);
}
