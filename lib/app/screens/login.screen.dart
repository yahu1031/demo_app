import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../meta/component/text_field.dart';
import '../const/global.const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController, _passController;
  final bool _otpSent = false;
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                controller: _phoneController,
                inputFormatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                icon: Icons.phone,
                hint: 'Phone number',
              ),
              if (_otpSent) const SizedBox(height: 10),
              if (_otpSent)
                CustomTextField(
                  controller: _passController,
                  isPassword: true,
                  icon: Icons.lock,
                  hint: 'Password',
                ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  await authService.authenticateUser('+917989152378');
                  // await Navigator.pushReplacementNamed(
                  //     context, RouteNames.home);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
