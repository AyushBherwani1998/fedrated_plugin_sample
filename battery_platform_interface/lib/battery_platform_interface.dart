import 'package:battery_platform_interface/battery_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class BatteryPluginInterface extends PlatformInterface {
  BatteryPluginInterface() : super(token: _token);

  static BatteryPluginInterface _batteryPluginInterface = BatteryMethodChannel();

  static final Object _token = Object();

  static BatteryPluginInterface get instance => _batteryPluginInterface;

  static set instance(BatteryPluginInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _batteryPluginInterface = instance;
  }

  Future<double> getBatteryLevel() async {
    throw UnimplementedError('getBatteryLevel() has not been implemented');
  }
}