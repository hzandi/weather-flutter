
import '../../../../domain/model/suggest_city_model.dart';

class SuggestCityDTO extends SuggestCityModel{

  SuggestCityDTO({
    required name,
    required lat,
    required lon,
    required country,}): super (
    name: name,
    lat: lat,
    lon: lon,
    country: country
  );

  factory SuggestCityDTO.fromJson(Map<String, dynamic> json) {
    String? name = json['name'];
    num? lat = json['lat'];
    num? lon = json['lon'];
    String? country = json['country'];
    return SuggestCityDTO(name: name, lat: lat, lon: lon, country: country);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['lat'] = lat;
    map['lon'] = lon;
    map['country'] = country;
    return map;
  }

}