part of 'home_bloc.dart';

class HomeState {
  CurrentWeatherStatus currentWeatherStatus;
  ForecastWeatherStatus forecastWeatherStatus;
  HomeState({required this.currentWeatherStatus, required this.forecastWeatherStatus});

  HomeState copyWith({
    CurrentWeatherStatus? newCurrentWeatherStatus,
    ForecastWeatherStatus? newForecastWeatherStatus
  }) {
    return HomeState(
        currentWeatherStatus: newCurrentWeatherStatus ?? currentWeatherStatus,
        forecastWeatherStatus: newForecastWeatherStatus ?? forecastWeatherStatus
    );
  }

}
