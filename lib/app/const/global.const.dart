import 'dart:io';


import '../../core/services/auth.service.dart';
import '../../core/services/db.services.dart';

bool get isIos => Platform.isIOS;

AuthService authService = AuthService();
Db db = Db();
bool isAuth = false;