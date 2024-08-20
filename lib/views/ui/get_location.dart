import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast_sagara_test/services/weather_service.dart';
import 'package:weather_forecast_sagara_test/theme.dart';
import 'package:weather_forecast_sagara_test/views/components/export.dart';
import 'package:weather_forecast_sagara_test/views/ui/weather.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  Position? _position;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await WeatherService.getCurrentLocation();
      setState(() {
        _position = position;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherScreen(
            latitude: _position!.latitude,
            longitude: _position!.longitude,
          ),
        ),
      );
    } catch (e) {
      print("Error get location $e");
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1C2546),
                  Color(0xFF864DAA),
                ],
              ),
            ),
          ),
          Center(
            child: isLoading == true
                ? Text(
                    "Anda tidak bisa menggunakan aplikasi, mohon izinkan lokasi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: kWhite),
                      HeightSpacer(height: 20),
                      Text(
                        "Mohon tunggu sebentar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
