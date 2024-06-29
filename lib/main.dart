import 'package:flutter/material.dart';
import 'package:flutter_chess/authentication/login_screen.dart';
import 'package:flutter_chess/authentication/sign_up_screen.dart';
import 'package:flutter_chess/constants.dart';
import 'package:flutter_chess/main_screens/about_screen.dart';
import 'package:flutter_chess/main_screens/game_screen.dart';
import 'package:flutter_chess/main_screens/game_time_screen.dart';
import 'package:flutter_chess/main_screens/home_screen.dart';
import 'package:flutter_chess/main_screens/settings_screen.dart';
import 'package:flutter_chess/providers/game_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GameProvider())
  ],
    
    child: const MyApp()),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const HomeScreen(),
      initialRoute: Constants.loginScreen,
      routes: {
        Constants.homeScreen: (context) => const HomeScreen(),
        Constants.gameScreen: (context) => const GameScreen(),
        Constants.settingScreen: (context) => const SettingsScreen(),
        Constants.aboutScreen: (context) => const AboutScreen(),
        Constants.gameTimeScreen: (context) => const GameTimeScreen(),
        Constants.loginScreen: (context) => const LoginScreen(),
        Constants.signUpScreen: (context) => const SignUpScreen(),
      },
    );
  }
}

