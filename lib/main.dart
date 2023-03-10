import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/pages/config_page.dart';
import 'package:sutindo_supir_app/pages/input_pengeluaran_page.dart';
import 'package:sutindo_supir_app/pages/login_page.dart';
import 'package:sutindo_supir_app/pages/home_page.dart';
import 'package:sutindo_supir_app/pages/rate_page.dart';
import 'package:sutindo_supir_app/pages/today_trip_page.dart';
import 'package:sutindo_supir_app/pages/splashscreen_page.dart';
import 'package:sutindo_supir_app/pages/detail_pengeluaran_page.dart';
import 'package:sutindo_supir_app/pages/update_progress_page.dart';
import 'package:sutindo_supir_app/pages/work_in_progress_page.dart';
import 'package:sutindo_supir_app/providers/area_provider.dart';
import 'package:sutindo_supir_app/providers/auth_provider.dart';
import 'package:sutindo_supir_app/providers/home_provider.dart';
import 'package:sutindo_supir_app/providers/menu_provider.dart';
import 'package:sutindo_supir_app/providers/pengeluaran_provider.dart';
import 'package:sutindo_supir_app/providers/rate_provider.dart';
import 'package:sutindo_supir_app/providers/today_trip_provider.dart';
import 'package:sutindo_supir_app/providers/work_in_progress_provider.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => MenuProvider()),
          ChangeNotifierProvider(create: (context) => TodayTripProvider()),
          ChangeNotifierProvider(create: (context) => WorkInProgressProvider()),
          ChangeNotifierProvider(create: (context) => RateProvider()),
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => PengeluaranProvider()),
          ChangeNotifierProvider(create: (context) => AreaProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) => const SplashScreenPage(),
            "/login": (context) => const LoginPage(),
            "/home": (context) => const HomePage(),
            "/wip": (context) => const WorkInProgressPage(),
            "/rate": (context) => const RatePage(),
            "/today-trip": (context) => const TodayTripPage(),
            "/input-pengeluaran": (context) => const InputPengeluaranPage(),
            "/update-progress": (context) => const UpdateProgressPage(),
            "/detail-pengeluaran": (context) => const DetailPengeluaranPage(),
            "/config": (context) => const ConfigPage(),
          },
        ));
  }
}
