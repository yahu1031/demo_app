import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/const/global.const.dart';
import 'app/const/route.const.dart';
import 'app/screens/home.screen.dart';
import 'app/screens/login.screen.dart';
import 'app/screens/splash.screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  authService.listenToUser().onData((User? data) {
    isAuth = data != null;
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteNames.splash,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case RouteNames.splash:
            return MaterialPageRoute<SplashScreen>(
              builder: (BuildContext context) => const SplashScreen(),
            );
          case RouteNames.home:
            return MaterialPageRoute<HomeScreen>(
              builder: (BuildContext context) => const HomeScreen(),
            );
          case RouteNames.login:
            return MaterialPageRoute<LoginScreen>(
              builder: (BuildContext context) => const LoginScreen(),
            );
          default:
            return MaterialPageRoute<Scaffold>(
              builder: (BuildContext context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
            );
        }
      },
    );
  }
}
