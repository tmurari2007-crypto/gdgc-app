import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Data class representing weather details for a destination
class DestinationWeather {
  final double temperature; // in Celsius
  final double windSpeed; // km/h
  final int weatherCode; // WMO weather code
  final String conditionDescription;
  final String weatherIcon;

  const DestinationWeather({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.conditionDescription,
    required this.weatherIcon,
  });

  /// Parse WMO Weather interpretation code into friendly readable text and emoji icon
  factory DestinationWeather.fromOpenMeteo(Map<String, dynamic> current) {
    final temp = (current['temperature_2m'] as num).toDouble();
    final wind = (current['wind_speed_10m'] as num?)?.toDouble() ?? 0.0;
    final code = (current['weather_code'] as num?)?.toInt() ?? 0;

    String desc;
    String icon;

    switch (code) {
      case 0:
        desc = 'Clear Sky';
        icon = '☀️';
        break;
      case 1:
      case 2:
      case 3:
        desc = 'Partly Cloudy';
        icon = '⛅';
        break;
      case 45:
      case 48:
        desc = 'Foggy';
        icon = '🌫️';
        break;
      case 51:
      case 53:
      case 55:
        desc = 'Drizzle';
        icon = '🌦️';
        break;
      case 61:
      case 63:
      case 65:
        desc = 'Rainy';
        icon = '🌧️';
        break;
      case 71:
      case 73:
      case 75:
        desc = 'Snowfall';
        icon = '❄️';
        break;
      case 80:
      case 81:
      case 82:
        desc = 'Rain Showers';
        icon = '🌦️';
        break;
      case 95:
      case 96:
      case 99:
        desc = 'Thunderstorm';
        icon = '⛈️';
        break;
      default:
        desc = 'Pleasant';
        icon = '🌤️';
        break;
    }

    return DestinationWeather(
      temperature: temp,
      windSpeed: wind,
      weatherCode: code,
      conditionDescription: desc,
      weatherIcon: icon,
    );
  }
}

/// WeatherService integrates with the free Open-Meteo REST API
/// (requires NO API key) using latitude and longitude.
class WeatherService {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  /// Fetch real-time weather given latitude and longitude coordinates.
  static Future<DestinationWeather> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude&current=temperature_2m,weather_code,wind_speed_10m',
    );

    try {
      final response = await http.get(uri).timeout(
        const Duration(seconds: 8),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final current = data['current'] as Map<String, dynamic>?;
        if (current != null) {
          return DestinationWeather.fromOpenMeteo(current);
        }
        throw Exception('Invalid weather payload');
      } else {
        throw Exception('Failed to load weather: HTTP ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('WeatherService error: $e');
      rethrow;
    }
  }
}
