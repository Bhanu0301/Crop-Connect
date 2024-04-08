// // import 'package:flutter/material.dart';

// // class WeatherScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Weather Screen'),
// //       ),
// //       body: Center(
// //         child: Text('Check the weather forecast on this screen!'),
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';

// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   String apiKey =
//       '07bcaf66812f01808c9ca20fa9d4b865'; // Replace 'YOUR_API_KEY' with your actual OpenWeatherMap API key
//   String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
//   double? temperature;
//   String? cityName;
//   String? weatherDescription;
//   String? weatherIconUrl;
//   int? humidity;
//   double? windSpeed;
//   double? precipitation;
//   List<dynamic>? hourlyForecast;

//   @override
//   void initState() {
//     super.initState();
//     getLocationAndWeather();
//   }

//   Future<void> getLocationAndWeather() async {
//     // Request permission to access the user's location
//     LocationPermission permission = await Geolocator.requestPermission();

//     if (permission == LocationPermission.denied) {
//       // Handle case where user denies permission
//       print('Location permission denied');
//       return;
//     }

//     // Get the current position (latitude and longitude)
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.medium,
//     );

//     // Fetch weather based on the user's location
//     fetchWeather(position.latitude, position.longitude);
//   }

//   Future<void> fetchWeather(double latitude, double longitude) async {
//     final url =
//         '$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         temperature = data['main']['temp'];
//         cityName = data['name'];
//         weatherDescription = data['weather'][0]['description'];
//         weatherIconUrl =
//             'https://openweathermap.org/img/w/${data['weather'][0]['icon']}.png';
//         humidity = data['main']['humidity'];
//         windSpeed = data['wind']['speed'];
//         precipitation = data.containsKey('rain')
//             ? data['rain']['1h']
//             : data.containsKey('snow')
//                 ? data['snow']['1h']
//                 : null;
//       });
//     } else {
//       // Handle error
//       print('Failed to load weather data: ${response.statusCode}');
//     }

//     // Fetch hourly forecast
//     final hourlyForecastUrl =
//         'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
//     final hourlyForecastResponse = await http.get(Uri.parse(hourlyForecastUrl));
//     if (hourlyForecastResponse.statusCode == 200) {
//       final hourlyData = jsonDecode(hourlyForecastResponse.body);
//       setState(() {
//         hourlyForecast = hourlyData['list'];
//       });
//     } else {
//       // Handle error
//       print(
//           'Failed to load hourly forecast: ${hourlyForecastResponse.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather'),
//       ),
//       body: temperature != null && cityName != null
//           ? Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       '${DateFormat('EEEE, MMMM d, hh:mm a').format(DateTime.now())}',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       temperature != null
//                           ? '${temperature!.toInt()}°C'
//                           : 'Unknown',
//                       style: TextStyle(fontSize: 30),
//                     ),
//                     SizedBox(height: 10),
//                     if (weatherIconUrl != null)
//                       Image.network(
//                         weatherIconUrl!,
//                         width: 100,
//                         height: 100,
//                       ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Current Weather: $weatherDescription',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     SizedBox(height: 10),
//                     if (humidity != null)
//                       Text(
//                         'Humidity: $humidity%',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     SizedBox(height: 10),
//                     if (windSpeed != null)
//                       Text(
//                         'Wind Speed: $windSpeed m/s',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     SizedBox(height: 10),
//                     if (precipitation != null)
//                       Text(
//                         'Precipitation: $precipitation mm',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Location: $cityName',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Hourly Forecast:',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       height: 120,
//                       child: hourlyForecast != null
//                           ? SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: List.generate(hourlyForecast!.length, (index) {
//                                   final forecast = hourlyForecast![index];
//                                   final dateTime = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
//                                   final temperature = forecast['main']['temp'];
//                                   final weatherIcon = forecast['weather'][0]['icon'];
//                                   return HourlyForecastCard(
//                                     time: '${DateFormat('h a').format(dateTime)}',
//                                     temperature: temperature,
//                                     weatherIcon: weatherIcon,
//                                   );
//                                 }),
//                               ),
//                             )
//                           : Center(child: CircularProgressIndicator()),
//                     ),

//                   ],
//                 ),
//               ),
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// class HourlyForecastCard extends StatelessWidget {
//   final String time;
//   final double temperature;
//   final String weatherIcon;

//   const HourlyForecastCard({
//     required this.time,
//     required this.temperature,
//     required this.weatherIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       margin: EdgeInsets.only(right: 10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.blue[100],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             time,
//             style: TextStyle(fontSize: 16),
//           ),
//           Image.network(
//             'https://openweathermap.org/img/w/$weatherIcon.png',
//             width: 50,
//             height: 50,
//           ),
//           Text(
//             '${temperature.toInt()}°C',
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey =
      '07bcaf66812f01808c9ca20fa9d4b865'; // Replace 'YOUR_API_KEY' with your actual OpenWeatherMap API key
  String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  double? temperature;
  String? cityName;
  String? weatherDescription;
  String? weatherIconUrl;
  int? humidity;
  double? windSpeed;
  double? precipitation;
  List<dynamic>? hourlyForecast;

  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  Future<void> getLocationAndWeather() async {
    // Request permission to access the user's location
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle case where user denies permission
      print('Location permission denied');
      return;
    }

    // Get the current position (latitude and longitude)
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );

    // Fetch weather based on the user's location
    fetchWeather(position.latitude, position.longitude);
  }

  Future<void> fetchWeather(double latitude, double longitude) async {
    final url =
        '$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        temperature = data['main']['temp'];
        cityName = data['name'];
        weatherDescription = data['weather'][0]['description'];
        weatherIconUrl =
            'https://openweathermap.org/img/w/${data['weather'][0]['icon']}.png';
        humidity = data['main']['humidity'];
        windSpeed = data['wind']['speed'];
        precipitation = data.containsKey('rain')
            ? data['rain']['1h']
            : data.containsKey('snow')
                ? data['snow']['1h']
                : null;
      });
    } else {
      // Handle error
      print('Failed to load weather data: ${response.statusCode}');
    }

    // Fetch hourly forecast
    final hourlyForecastUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final hourlyForecastResponse = await http.get(Uri.parse(hourlyForecastUrl));
    if (hourlyForecastResponse.statusCode == 200) {
      final hourlyData = jsonDecode(hourlyForecastResponse.body);
      setState(() {
        hourlyForecast = hourlyData['list'];
      });
    } else {
      // Handle error
      print(
          'Failed to load hourly forecast: ${hourlyForecastResponse.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${DateFormat('EEEE, MMMM d, hh:mm a').format(DateTime.now())}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  temperature != null
                      ? '${temperature!.toInt()}°C'
                      : 'Unknown',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 10),
                if (weatherIconUrl != null)
                  Image.network(
                    weatherIconUrl!,
                    width: 100,
                    height: 100,
                  ),
                SizedBox(height: 10),
                Text(
                  'Current Weather: $weatherDescription',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                if (humidity != null)
                  Text(
                    'Humidity: $humidity%',
                    style: TextStyle(fontSize: 20),
                  ),
                SizedBox(height: 10),
                if (windSpeed != null)
                  Text(
                    'Wind Speed: $windSpeed m/s',
                    style: TextStyle(fontSize: 20),
                  ),
                SizedBox(height: 10),
                if (precipitation != null)
                  Text(
                    'Precipitation: $precipitation mm',
                    style: TextStyle(fontSize: 20),
                  ),
                SizedBox(height: 10),
                Text(
                  'Location: $cityName',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  'Hourly Forecast:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                hourlyForecast != null
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(hourlyForecast!.length,
                              (index) {
                            final forecast = hourlyForecast![index];
                            final dateTime = DateTime.fromMillisecondsSinceEpoch(
                                forecast['dt'] * 1000);
                            final temperature = forecast['main']['temp'];
                            final weatherIcon =
                                forecast['weather'][0]['icon'];
                            return HourlyForecastCard(
                              time: '${DateFormat('h a').format(dateTime)}',
                              temperature: temperature,
                              weatherIcon: weatherIcon,
                            );
                          }),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final double temperature;
  final String weatherIcon;

  const HourlyForecastCard({
    required this.time,
    required this.temperature,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 16),
          ),
          Image.network(
            'https://openweathermap.org/img/w/$weatherIcon.png',
            width: 50,
            height: 50,
          ),
          Text(
            '${temperature.toInt()}°C',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
