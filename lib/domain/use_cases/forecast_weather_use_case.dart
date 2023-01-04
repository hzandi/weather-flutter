import 'package:weather/core/resources/response_state.dart';
import 'package:weather/domain/model/forecast_weather_model.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/weather_repository.dart';

class ForecastWeatherUseCase extends UseCase<DataState<ForecastWeatherModel>, Params>{
  final WeatherRepository _weatherRepository;
  ForecastWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<ForecastWeatherModel>> call(Params input) {
    return _weatherRepository.getWeatherForecast(input.lat, input.lon);
  }

}

class Params {
  final double lat;
  final double lon;
  Params._(this.lat, this.lon);

  static Params forQuery(double lat, double lon) {
    return Params._(lat, lon);
  }
}