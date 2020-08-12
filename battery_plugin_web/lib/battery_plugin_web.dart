library battery_plugin_web;

import 'dart:html' as html;

import 'package:battery_platform_interface/battery_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class BatteryPluginWeb extends BatteryPluginInterface {

  static void registerWith(Registrar registrar){
    BatteryPluginInterface.instance = BatteryPluginWeb();
  }

  @override
  Future<double> getBatteryLevel() async {
    try {
      html.BatteryManager battery = await html.window.navigator.getBattery();
      return battery.level * 100;
    }catch(error) {
      throw PlatformException(code: 'NOT ABLE TO GET',message: 'SORRY', details: null);
    }
  }
}