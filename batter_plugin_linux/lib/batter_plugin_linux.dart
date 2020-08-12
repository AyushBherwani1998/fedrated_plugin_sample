
import 'dart:async';

import 'package:flutter/services.dart';

class BatterPluginLinux {
  static const MethodChannel _channel =
      const MethodChannel('batter_plugin_linux');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
