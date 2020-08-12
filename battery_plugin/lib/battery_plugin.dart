
import 'dart:async';

import 'package:battery_platform_interface/battery_platform_interface.dart';

Future<double> getBatteryLevel() async {
  return await BatteryPluginInterface.instance.getBatteryLevel();
}
