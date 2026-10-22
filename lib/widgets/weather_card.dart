import 'package:flutter/material.dart';
import '../utils/weather_service.dart';
import '../utils/constants.dart';

/// WeatherCard asynchronously fetches and displays real-time weather metrics
/// from Open-Meteo using the destination's latitude and longitude.
class WeatherCard extends StatefulWidget {
  final double latitude;
  final double longitude;

  const WeatherCard({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  late Future<DestinationWeather> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    _weatherFuture = WeatherService.fetchWeather(
      latitude: widget.latitude,
      longitude: widget.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: FutureBuilder<DestinationWeather>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.primaryTeal,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'Fetching real-time weather...',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            );
          }

          // Error state with retry
          if (snapshot.hasError) {
            return Row(
              children: [
                const Icon(Icons.cloud_off_rounded, color: Colors.orange, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Live weather currently unavailable',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  color: AppColors.primaryTeal,
                  tooltip: 'Retry',
                  onPressed: () {
                    setState(() {
                      _fetchWeather();
                    });
                  },
                ),
              ],
            );
          }

          // Data loaded
          final weather = snapshot.data!;
          return Row(
            children: [
              // Weather emoji/icon
              Text(
                weather.weatherIcon,
                style: const TextStyle(fontSize: 34),
              ),
              const SizedBox(width: 14),
              // Temperature and Condition
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${weather.temperature.toStringAsFixed(1)}°C',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryTeal.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Live API',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryTeal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${weather.conditionDescription} • Wind ${weather.windSpeed.toStringAsFixed(0)} km/h',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
