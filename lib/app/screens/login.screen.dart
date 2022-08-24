import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../meta/component/sheets/otp.sheet.dart';
import '../../meta/component/text_field.dart';
import '../../meta/toast.dart';
import '../const/global.const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController, _passController;
  bool _otpSent = false;
  String? vCode;
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
              Image.asset(
                'assets/logo_transp.png',
                height: 200,
                color: const Color(0xFF6995A6),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _phoneController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                icon: Icons.phone,
                textInputType: TextInputType.phone,
                hint: 'Phone number',
              ),
              const SizedBox(height: 10),
              _otpSent
                  ? const CircularProgressIndicator.adaptive()
                  : TextButton(
                      onPressed: () async {
                        if (_phoneController.text.length < 10) {
                          showToast(
                              'Please enter a valid phone number', context);
                          return;
                        }
                        setState(() {
                          _otpSent = true;
                        });
                        await authService.getOtp('+91${_phoneController.text}',
                            codeAutoRetrievalTimeout: (String _) {
                          setState(() => _otpSent = false);
                          // Navigator.pop(context);
                        }, codeSent: (String verificationId, __) async {
                          setState(() {
                            vCode = verificationId;
                          });
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: false,
                            isDismissible: true,
                            enableDrag: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            context: context,
                            builder: (BuildContext context) => OtpModalSheet(
                              vCode: vCode,
                              // passController: _passController,
                              onFailed: () {
                                // setState(() {
                                //   _otpSent = false;
                                // });
                                // Navigator.pop(context);
                                // showToast('Invalid OTP', context, isError: true);
                              },
                            ),
                          ).whenComplete(
                              () => setState(() => _otpSent = false));
                        });
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
