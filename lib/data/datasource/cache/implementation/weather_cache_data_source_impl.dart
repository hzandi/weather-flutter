import 'package:weather/data/datasource/cache/abstraction/weather_cache_data_source.dart';
import '../database/city_dao.dart';
import '../entity/city_entity.dart';

class WeatherCacheDataSourceImpl extends WeatherCacheDataSource {
  CurrentWeatherDao currentWeatherDao;

  WeatherCacheDataSourceImpl(this.currentWeatherDao);

  @override
  Future<CurrentWeatherEntity?> findCityByName(String name) async {
    CurrentWeatherEntity? currentWeatherEntity =  await currentWeatherDao.findCityByName(name);
    return currentWeatherEntity;
  }

  @override
  Future<int> insertCity(CurrentWeatherEntity currentWeatherEntity) async {
    int result = await currentWeatherDao.insertCity(currentWeatherEntity);
    return result;
  }

}