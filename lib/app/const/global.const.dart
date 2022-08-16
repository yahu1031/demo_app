import 'dart:io';

import '../../core/services/auth.service.dart';

bool get isIos => Platform.isIOS;

AuthService authService = AuthService();