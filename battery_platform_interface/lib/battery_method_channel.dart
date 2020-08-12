import 'package:battery_platform_interface/battery_platform_interface.dart';
import 'package:flutter/services.dart';

class BatteryMethodChannel extends BatteryPluginInterface {
  static const MethodChannel methodChannel = MethodChannel('battery');

  @override
  Future<double> getBatteryLevel() async{
    final result = await methodChannel.invokeMethod('getBatteryLevel');
    return result as double;
  }
}