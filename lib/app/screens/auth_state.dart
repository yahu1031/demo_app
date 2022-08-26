import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/auth.notifier.dart';
import 'home.screen.dart';
import 'login.screen.dart';

class StateCheck extends StatefulWidget {
  const StateCheck({Key? key}) : super(key: key);
  @override
  StateCheckState createState() => StateCheckState();
}

class StateCheckState extends State<StateCheck> {
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider<GoogleSignInProvider>(
          create: (BuildContext context) => GoogleSignInProvider(),
          child: StreamBuilder<dynamic>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              GoogleSignInProvider provider =
                  Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return const LoginScreen();
                } else {
                  return const HomeScreen();
                }
              }
            },
          ),
        ),
      );
}
