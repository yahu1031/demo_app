import 'dart:io';

import 'package:flutter/material.dart';

/// pass [isError] true to have a red bg, [isSuccess] true to have a green bg.
void showToast(String message, BuildContext context,
        {Color? bgColor,
        double? toastWidth,
        double fontSize = 12,
        int duration = 3,
        double gravity = 10.0,
        bool isError = false}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            color: isError ? Colors.white : Colors.black,
          ),
        ),
        duration: const Duration(milliseconds: 3000),
        elevation: 0,
        margin: toastWidth != null
            ? null
            : EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: gravity),
        backgroundColor: isError ? Colors.red : Colors.white,
        padding: const EdgeInsets.all(10),
        width: toastWidth,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Platform.isAndroid ? 50 : 10)),
      ),
    );
