import 'package:flutter/material.dart';

import '../const/global.const.dart';
import '../const/route.const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(
      const Duration(milliseconds: 1500),
      () => Navigator.pushReplacementNamed(
          context, isAuth ? RouteNames.home : RouteNames.login),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6995A6),
      body: Center(
        child: Image.asset('assets/logo.jpeg'),
      ),
    );
  }
}
