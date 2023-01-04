import 'package:flutter/cupertino.dart';
import 'package:weather/core/utils/date_utils.dart';

class AssetUtils {
  static AssetImage getBackgroundImage() {
    var currentHour = DateUtils.getCurrentHour();
    if (6 >= currentHour) {
      return const AssetImage("assets/images/night.jpg");
    }
    else if (20 >= currentHour) {
      return const AssetImage("assets/images/day.jpg");
    }
    else {
      return const AssetImage("assets/images/night.jpg");
    }
  }


  static Image setIconForMain(description, height) {
    if (description == "clear sky") {
      return Image(image: AssetImage('assets/images/icons8-sun-96.png',),height: height,);
    } else if (description == "few clouds") {
      return Image(image: AssetImage('assets/images/icons8-partly-cloudy-day-80.png'),height: height);
    } else if (description.contains("clouds")) {
      return Image(image: AssetImage('assets/images/icons8-clouds-80.png'),height: height);
    } else if (description.contains("thunderstorm")) {
      return Image(image: AssetImage('assets/images/icons8-storm-80.png'),height: height);
    } else if (description.contains("drizzle")) {
      return Image(image: AssetImage('assets/images/icons8-rain-cloud-80.png'),height: height);
    } else if (description.contains("rain")) {
      return Image(image: AssetImage('assets/images/icons8-heavy-rain-80.png'),height: height);
    } else if (description.contains("snow")) {
      return Image(image: AssetImage('assets/images/icons8-snow-80.png'),height: height);
    } else {
      return Image(image: AssetImage('assets/images/icons8-windy-weather-80.png'),height: height);
    }
  }
}