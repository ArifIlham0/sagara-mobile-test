import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_forecast_sagara_test/models/weather_res.dart';
import 'package:weather_forecast_sagara_test/theme.dart';
import 'package:weather_forecast_sagara_test/views/components/export.dart';

class WeatherDetail extends StatelessWidget {
  const WeatherDetail({
    super.key,
    this.weather,
    this.formattedDate,
    this.formattedTime,
  });

  final WeatherResponse? weather;
  final String? formattedDate;
  final String? formattedTime;

  @override
  Widget build(BuildContext context) {
    String weatherCondition = weather?.weather?[0].main ?? 'Clear';
    String imagePath;

    switch (weatherCondition) {
      case 'Clouds':
        imagePath = 'assets/cloud.png';
        break;
      case 'Rain':
        imagePath = 'assets/rain.png';
        break;
      case 'Clear':
        imagePath = 'assets/clear.png';
        break;
      case 'Thunderstorm':
        imagePath = 'assets/thunder.png';
        break;
      default:
        imagePath = 'assets/clear.png';
    }

    return Column(
      children: [
        Text(
          weather!.name!,
          style: TextStyle(
            fontSize: 25,
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${weather?.main?.temp?.toStringAsFixed(2)}°C",
          style: TextStyle(
            fontSize: 40,
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          weather!.weather![0].main!,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        HeightSpacer(height: 30),
        Text(
          formattedDate!,
          style: TextStyle(
            fontSize: 18,
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formattedTime!,
          style: TextStyle(
            fontSize: 18,
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        HeightSpacer(height: 10),
        Container(
          height: 200.h,
          width: 200.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
            ),
          ),
        ),
        HeightSpacer(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Container(
            height: 95.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF864DAA),
                  Color(0xFF1C2546),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.wind_power,
                            color: kWhite,
                            size: 18.w,
                          ),
                          HeightSpacer(height: 5),
                          weatherInfo(
                            title: "Wind",
                            value: "${weather?.wind?.speed} km/h",
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: kWhite,
                            size: 18.w,
                          ),
                          HeightSpacer(height: 5),
                          weatherInfo(
                            title: "Max Temp",
                            value:
                                "${weather?.main?.tempMax?.toStringAsFixed(2)}°C",
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: kWhite,
                            size: 18.w,
                          ),
                          HeightSpacer(height: 5),
                          weatherInfo(
                            title: "Min Temp",
                            value:
                                "${weather?.main?.tempMin?.toStringAsFixed(2)}°C",
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column weatherInfo({String? title, String? value}) {
    return Column(
      children: [
        Text(
          title!,
          style: TextStyle(
            color: kWhite,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
        Text(
          value!,
          style: TextStyle(
            color: kWhite,
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
