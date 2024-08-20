import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_sagara_test/controllers/weather_provider.dart';
import 'package:weather_forecast_sagara_test/theme.dart';
import 'package:weather_forecast_sagara_test/views/components/export.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({
    super.key,
    this.latitude,
    this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        weatherProvider.getCurrentWeather(latitude!, longitude!);
        weatherProvider.getListWeather(latitude!, longitude!);

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
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
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: FutureBuilder(
                          future: weatherProvider.weather,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Column(
                                children: [
                                  HeightSpacer(height: 150),
                                  CircularProgressIndicator(
                                      backgroundColor: kWhite),
                                  HeightSpacer(height: 200),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      "Terjadi kesalahan: ${snapshot.error}"));
                            } else {
                              final weatherSnapshot = snapshot.data;

                              return WeatherDetail(
                                weather: weatherSnapshot,
                                formattedDate: formattedDate,
                                formattedTime: formattedTime,
                              );
                            }
                          },
                        ),
                      ),
                      HeightSpacer(height: 20),
                      Text(
                        "Next 3 days",
                        style: TextStyle(
                          fontSize: 16,
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      HeightSpacer(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          height: 120.h,
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
                            padding: EdgeInsets.symmetric(
                                vertical: 12.w, horizontal: 15.w),
                            child: FutureBuilder(
                              future: weatherProvider.weatherList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Column(
                                    children: [
                                      CircularProgressIndicator(
                                          backgroundColor: kWhite),
                                      HeightSpacer(height: 50),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                        "Terjadi kesalahan: ${snapshot.error}"),
                                  );
                                } else {
                                  final weatherSnapshot = snapshot.data;

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: weatherSnapshot?.list?.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final weathers =
                                          weatherSnapshot?.list?[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25.h,
                                              width: 25.w,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/" +
                                                        (() {
                                                          switch (weathers
                                                              ?.weather![0]
                                                              .main!) {
                                                            case 'Clouds':
                                                              return 'cloud.png';
                                                            case 'Rain':
                                                              return 'rain.png';
                                                            case 'Clear':
                                                              return 'clear.png';
                                                            case 'Thunderstorm':
                                                              return 'thunder.png';
                                                            default:
                                                              return 'clear.png';
                                                          }
                                                        }()),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            HeightSpacer(height: 5),
                                            Text(
                                              weathers!.weather![0].main!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('HH:mm').format(
                                                DateFormat(
                                                        'yyyy-MM-dd HH:mm:ss')
                                                    .parse(weathers.dtTxt
                                                        .toString()),
                                              ),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                            Text(
                                              DateFormat('yyyy-MM-dd').format(
                                                DateFormat(
                                                        'yyyy-MM-dd HH:mm:ss')
                                                    .parse(weathers.dtTxt
                                                        .toString()),
                                              ),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
