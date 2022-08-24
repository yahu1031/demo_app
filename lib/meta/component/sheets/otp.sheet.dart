import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../app/const/global.const.dart';
import '../../../app/const/route.const.dart';
import '../modal_sheet.dart';
import '../../toast.dart';

class OtpModalSheet extends StatefulWidget {
  const OtpModalSheet({
    Key? key,
    required this.onFailed,
    required this.vCode,
  }) : super(key: key);

  final Function onFailed;
  final String? vCode;

  @override
  State<OtpModalSheet> createState() => _OtpModalSheetState();
}

class _OtpModalSheetState extends State<OtpModalSheet> {
  // late StreamController<ErrorAnimationType> errorController;
  TextEditingController? _passController;
  bool validating = false;
  @override
  void initState() {
    // errorController = StreamController<ErrorAnimationType>();
    _passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // errorController.close();
    _passController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalSheetBody(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'OTP sent to your phone number',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            PinCodeTextField(
              appContext: context,
              keyboardType: TextInputType.number,
              length: 6,
              obscureText: false,
              enabled: true,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              enablePinAutofill: true,
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: false,
              // errorAnimationController: errorController,
              controller: _passController,
              onCompleted: (String v) {
                print('Completed');
              },
              onChanged: print,
              beforeTextPaste: (String? text) {
                print('Allowing to paste $text');
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                setState(() => validating = true);
                UserCredential? usrCreds = await authService.verifyOtp(
                    widget.vCode!, _passController!.text);
                if (usrCreds != null) {
                  setState(() => validating = true);
                  Navigator.pop(context);
                  await Navigator.pushNamed(context, RouteNames.home);
                } else {
                  showToast('Invalid OTP', context);
                  setState(() => validating = false);
                  Navigator.pop(context);
                }
              },
              child: validating
                  ? const CircularProgressIndicator.adaptive()
                  : const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
