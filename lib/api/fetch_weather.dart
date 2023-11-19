import 'dart:convert';

import 'package:weatherapp_starter_project/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/model/weather_data_daily.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';
import 'package:weatherapp_starter_project/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  // procecssing the data from response -> to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    var jsonHourly = ''' [
              {"dt": 1637438400, "temp": 22.5, "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]},
              {"dt": 1637442000, "temp": 23.0, "weather": [{"id": 801, "main": "Clouds", "description": "few clouds", "icon": "02d"}]}
            ]
          ''';
    var jsonDaily = ''' [
              {"dt": 1637438400, "temp": {"day": 22.5, "night": 18.0}, "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]},
              {"dt": 1637524800, "temp": {"day": 23.0, "night": 17.5}, "weather": [{"id": 801, "main": "Clouds", "description": "few clouds", "icon": "02d"}]}]''';
    var jsonCurrent = '''{
              "dt": 1637365919,
              "sunrise": 1637350000,
              "sunset": 1637390000,
              "temp": 25.0,
              "feels_like": 26.0,
              "pressure": 1015,
              "humidity": 60,
              "dew_point": 18.0,
              "uvi": 5.0,
              "clouds": 0,
              "visibility": 10000,
              "wind_speed": 3.5,
              "wind_deg": 180,
              "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]
            }''';
    jsonString['current'] = jsonDecode(jsonCurrent);
    jsonString['hourly'] = jsonDecode(jsonHourly);
    jsonString['daily'] = jsonDecode(jsonDaily);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    return weatherData!;
  }
}
