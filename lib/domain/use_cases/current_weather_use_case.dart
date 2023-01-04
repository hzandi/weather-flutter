import 'package:weather/core/resources/response_state.dart';

import '../../../../core/use_case/use_case.dart';
import '../model/current_weather_model.dart';
import '../repository/weather_repository.dart';

class CurrentWeatherUseCase extends UseCase<DataState<CurrentWeatherModel>, Params>{
  final WeatherRepository _currentWeatherRepository;
  CurrentWeatherUseCase(this._currentWeatherRepository);

  @override
  Future<DataState<CurrentWeatherModel>> call(Params input) {
    return _currentWeatherRepository.getCurrentWeather(input.city);
  }

}

class Params {
  final String city;
  Params._(this.city);

  static Params forQuery(String city) {
    return Params._(city);
  }
}