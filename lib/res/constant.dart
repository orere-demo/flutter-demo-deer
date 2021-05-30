import 'package:flutter/foundation.dart';

class Constant {
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  // static bool isDriverTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';
}
