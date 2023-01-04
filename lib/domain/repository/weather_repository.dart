import 'package:weather/domain/model/current_weather_model.dart';
import 'package:weather/domain/model/forecast_weather_model.dart';
import 'package:weather/domain/model/suggest_city_model.dart';

import '../../../../core/resources/response_state.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentWeatherModel>> getCurrentWeather(String city);
  Future<DataState<CurrentWeatherModel>> getCurrentWeatherFromCache(String city);
  Future<DataState<ForecastWeatherModel>> getWeatherForecast(double lat, double lon);
  Future<List<SuggestCityModel>> getCitySuggestion(String cityName);
}
