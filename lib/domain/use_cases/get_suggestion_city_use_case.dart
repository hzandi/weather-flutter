import 'package:weather/domain/model/suggest_city_model.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/weather_repository.dart';

class GetSuggestionCityUseCase implements UseCase<List<SuggestCityModel>, Params>{
  final WeatherRepository _weatherRepository;
  GetSuggestionCityUseCase(this._weatherRepository);

  @override
  Future<List<SuggestCityModel>> call(Params params) {
    return _weatherRepository.getCitySuggestion(params.cityPrefix);
  }

}

class Params {
  final String cityPrefix;
  Params._(this.cityPrefix);

  static Params forQuery(String cityPrefix) {
    return Params._(cityPrefix);
  }
}