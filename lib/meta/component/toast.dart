import '../../app/const/global.const.dart';
import 'package:flutter/material.dart';

class Toast {
  static Future<void> show(BuildContext? context, String msg,
      {double? width, bool isError = false}) async {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: isError ? Colors.white : Colors.black,
          ),
        ),
        duration: const Duration(milliseconds: 2300),
        elevation: 0.5,
        margin: width != null
            ? null
            : EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
        backgroundColor: isError ? Colors.red[700] : Colors.white70,
        padding: const EdgeInsets.all(10),
        width: width,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius:
              isIos ? BorderRadius.circular(10) : BorderRadius.circular(50),
        ),
      ),
    );
  }
}
