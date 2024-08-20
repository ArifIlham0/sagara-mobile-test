import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_sagara_test/controllers/weather_provider.dart';
import 'package:weather_forecast_sagara_test/theme.dart';
import 'package:weather_forecast_sagara_test/views/ui/get_location.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => WeatherProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather Forecast',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFF864DAA),
            iconTheme: IconThemeData(color: kWhite),
            primarySwatch: Colors.grey,
          ),
          home: GetLocation(),
        );
      },
    );
  }
}
