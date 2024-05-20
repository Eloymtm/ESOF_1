import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:src/pages/auth_page.dart';
import 'package:src/pages/choose_location_page.dart';
import 'package:src/pages/login_page.dart';
import 'package:src/pages/map_page.dart';
import 'package:src/pages/lift_page.dart';
import 'package:src/pages/profile/add_car_page.dart';
import 'package:src/pages/profile/my_cars_page.dart';
import 'package:src/pages/profile/my_lifts_page.dart';
import 'package:src/pages/profile/profile_page.dart';
import 'package:src/pages/register_page.dart';
import 'package:src/pages/mainPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthPage(),
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          'profile/profile_page': (context) => const ProfilePage(),
          '/map_page': (context) => const MapPage(),
          '/lift_page': (context) => const LiftPage(),
          '/login_page': (context) => LoginPage(),
          '/register_page': (context) => RegisterPage(),
          '/main_page':(context) => const MainPage(),
          '/choose_location_page': (context) => MyPlacePickerPage(),
          '/my_cars_page': (context) => MyCarsPage(),
          '/add_car_page': (context) => AddCarPage(),
          '/my_lifts_page': (context) => MyLiftsPage(),
        });
  }
}
