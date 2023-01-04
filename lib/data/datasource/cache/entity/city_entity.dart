
import 'package:floor/floor.dart';


@entity
class CurrentWeatherEntity {

  CurrentWeatherEntity({
    required this.id,
    required this.weather,
    required this.coord,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.name,
    required this.cod
  });

  @primaryKey
  int? id;
  List<WeatherEntity?>? weather;
  CoordEntity? coord;
  String? base;
  MainEntity? main;
  int? visibility;
  WindEntity? wind;
  RainEntity? rain;
  CloudsEntity? clouds;
  int? dt;
  SysEntity? sys;
  int? timezone;
  String? name;
  int? cod;

  Map toJson() => {
    'id': id,
    'weather': weather,
    'coord': coord,
    'base': base,
    'main': main,
    'visibility': visibility,
    'wind': wind,
    'rain': rain,
    'clouds': clouds,
    'dt': dt,
    'sys': sys,
    'timezone': timezone,
    'name': name,
    'cod': cod,
  };

  CurrentWeatherEntity.fromJson(Map<String, dynamic> json) {
    List<WeatherEntity?>? weather = <WeatherEntity?>[];
    if (json['weather'] != null) {
      json['weather'].forEach((v) {
        weather.add(WeatherEntity.fromJson(v));
      });
    }
      base = json['base'];
      clouds=json['clouds'] != null ? CloudsEntity.fromJson(json['clouds']) : null;
      cod=json['cod'];
      coord=json['coord'] != null ? CoordEntity.fromJson(json['coord']) : null;
      dt=json['dt'];
      id= json['id'];
      main=json['main'] != null ? MainEntity.fromJson(json['main']) : null;
      name= json['name'];
      rain=json['rain'] != null ? RainEntity.fromJson(json['rain']) : null;
      sys=json['sys'] != null ? SysEntity.fromJson(json['sys']) : null;
      timezone=json['timezone'];
      visibility=json['visibility'];
      wind=json['wind'] != null ? WindEntity.fromJson(json['wind']) : null;
  }
}

@entity
class CoordEntity {

  CoordEntity({
    required this.lon,
    required this.lat,
  });

  num? lon;
  num? lat;

  CoordEntity.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map toJson() => {
    'lon': lon,
    'lat': lat,
  };
}


@entity
class MainEntity {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  int? pressure;
  int? humidity;

  MainEntity({required this.temp, required this.feelsLike, required this.tempMin, required this.tempMax,
    required this.pressure, required this.humidity});

  Map toJson() => {
    'temp': temp,
    'feelsLike': feelsLike,
    'tempMin': tempMin,
    'tempMax': tempMax,
    'pressure': pressure,
    'humidity': humidity
  };

  MainEntity.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feelsLike'];
    tempMin = json['tempMin'];
    tempMax = json['tempMax'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }
}

@entity
class WindEntity {
  num? speed;
  int? deg;
  num? gust;

  WindEntity({required this.speed, required this.deg, required this.gust});

  Map toJson() => {
    'speed': speed,
    'deg': deg,
    'gust': gust
  };

  WindEntity.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }
}

@entity
class RainEntity {
  num? d1h;

  RainEntity({required this.d1h});

  Map toJson() => {
    'd1h': d1h,
  };

  RainEntity.fromJson(Map<String, dynamic> json) {
    d1h = json['d1h'];
  }
}

@entity
class CloudsEntity {
  int? all;

  CloudsEntity({required this.all});

  Map toJson() => {
    'all': all,
  };

  CloudsEntity.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

@entity
class SysEntity {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  SysEntity({required this.type, required this.id, required this.country, required this.sunrise, required this.sunset});

  Map toJson() => {
    'type': type,
    'id': id,
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset,
  };

  SysEntity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

}

@entity
class WeatherEntity {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherEntity({required this.id, required this.main, required this.description, required this.icon});


  Map toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };

  WeatherEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

