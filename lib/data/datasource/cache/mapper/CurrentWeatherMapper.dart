import 'package:weather/core/mapper/mapper.dart';
import 'package:weather/domain/model/current_weather_model.dart';

import '../entity/city_entity.dart';

class CurrentWeatherMapper extends EntityMapper<CurrentWeatherEntity, CurrentWeatherModel> {

  @override
  CurrentWeatherModel mapFromEntity(CurrentWeatherEntity entity) {
    return CurrentWeatherModel(coord: _mapFromCoordEntity(entity.coord),
      weather: _mapFromWeatherModelEntity(entity.weather),
      base: entity.base,
      main: _mapFromMainEntity(entity.main),
      visibility: entity.visibility,
      wind: _mapFromWindEntity(entity.wind),
      rain: _mapFromRainEntity(entity.rain),
      clouds: _mapFromCloudsEntity(entity.clouds),
      dt: entity.dt,
      sys: _mapFromSysEntity(entity.sys),
      timezone: entity.timezone,
      id: entity.id,
      name: entity.name,
      cod: entity.cod
    );
  }

  CoordModel? _mapFromCoordEntity(CoordEntity? entity) {
    return entity == null ? null : CoordModel(lon: entity.lon, lat: entity.lat);
  }

  MainModel? _mapFromMainEntity(MainEntity? entity) {
    return entity == null ? null : MainModel(temp: entity.temp, feelsLike: entity.feelsLike, tempMin: entity.tempMin, tempMax: entity.tempMax, pressure: entity.pressure, humidity: entity.humidity);
  }

  WindModel? _mapFromWindEntity(WindEntity? entity) {
    return entity == null ? null : WindModel(speed: entity.speed, deg: entity.deg, gust: entity.gust);
  }

  RainModel? _mapFromRainEntity(RainEntity? entity) {
    return entity == null ? null : RainModel(d1h: entity.d1h);
  }

  CloudsModel? _mapFromCloudsEntity(CloudsEntity? entity) {
    return entity == null ? null : CloudsModel(all: entity.all);
  }

  SysModel? _mapFromSysEntity(SysEntity? entity) {
    return entity == null ? null : SysModel(id: entity.id, sunrise: entity.sunset, sunset: entity.sunset, country: entity.country, type: entity.type);
  }

  List<WeatherModel?>? _mapFromWeatherModelEntity(List<WeatherEntity?>? weatherEntityList) {
    List<WeatherModel?>? listWeatherModel = List.empty(growable: true);
    if (weatherEntityList!=null) {
      for(var item in weatherEntityList) {
        listWeatherModel.add(_mapFromWeatherEntity(item));
      }
      return listWeatherModel;
    }
    return null;
  }

  WeatherModel? _mapFromWeatherEntity(WeatherEntity? entity) {
    if (entity == null) {
      return null;
    }
    return WeatherModel(id: entity.id, main: entity.main, description: entity.description, icon: entity.icon);
  }

  @override
  CurrentWeatherEntity mapToEntity(CurrentWeatherModel domainModel) {
    return CurrentWeatherEntity(id: domainModel.id!,
        coord: _mapToCoordModel(domainModel.coord),
        base: domainModel.base,
        main: _mapToMainModel(domainModel.main),
        visibility: domainModel.visibility,
        wind: _mapToWindModel(domainModel.wind),
        rain: _mapToRainModel(domainModel.rain),
        clouds: _mapToCloudsModel(domainModel.clouds),
        dt: domainModel.dt,
        sys: _mapToSysModel(domainModel.sys),
        timezone: domainModel.timezone,
        name: domainModel.name,
        cod: domainModel.cod,
        weather: _mapToWeatherModelList(domainModel.weather));
  }

  CoordEntity? _mapToCoordModel(CoordModel? entity) {
    return entity == null ? null : CoordEntity(lon: entity.lon, lat: entity.lat);
  }

  MainEntity? _mapToMainModel(MainModel? entity) {
    return entity == null ? null : MainEntity(temp: entity.temp, feelsLike: entity.feelsLike, tempMin: entity.tempMin, tempMax: entity.tempMax, pressure: entity.pressure, humidity: entity.humidity);
  }

  WindEntity? _mapToWindModel(WindModel? entity) {
    return entity == null ? null : WindEntity(speed: entity.speed, deg: entity.deg, gust: entity.gust);
  }

  RainEntity? _mapToRainModel(RainModel? entity) {
    return entity == null ? null : RainEntity(d1h: entity.d1h);
  }

  CloudsEntity? _mapToCloudsModel(CloudsModel? entity) {
    return entity == null ? null : CloudsEntity(all: entity.all);
  }

  SysEntity? _mapToSysModel(SysModel? entity) {
    return entity == null ? null : SysEntity(id: entity.id, sunrise: entity.sunset, sunset: entity.sunset, country: entity.country, type: entity.type);
  }

  List<WeatherEntity?>? _mapToWeatherModelList(List<WeatherModel?>? weatherModelList) {
    List<WeatherEntity?> listWeatherEntity = List.empty(growable: true);
    if (weatherModelList!=null) {
      for(var item in weatherModelList) {
        listWeatherEntity.add(_mapToWeatherEntity(item));
      }
      return listWeatherEntity;
    }
    return null;
  }

  WeatherEntity? _mapToWeatherEntity(WeatherModel? model) {
    if (model == null) {
      return null;
    }
    return WeatherEntity(id: model.id, main: model.main, description: model.description, icon: model.icon);
  }
}
