
import '../entity/city_entity.dart';

abstract class WeatherCacheDataSource {
  Future<CurrentWeatherEntity?> findCityByName(String name);
  Future<int> insertCity(CurrentWeatherEntity currentWeatherEntity);
}
