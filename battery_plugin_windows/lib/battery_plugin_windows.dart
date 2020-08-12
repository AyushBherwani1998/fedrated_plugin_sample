
import 'dart:async';

import 'package:flutter/services.dart';

class BatteryPluginWindows {
  static const MethodChannel _channel =
      const MethodChannel('battery_plugin_windows');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
