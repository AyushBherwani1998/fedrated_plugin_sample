import 'package:battery_plugin/battery_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double batteryLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Federated Plugin Demo'),
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                batteryLevel == null
                    ? SizedBox.shrink()
                    : Text('Battery Level: $batteryLevel',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 16),
                RaisedButton(
                  child: Text('Get Battery Level'),
                  onPressed: () async {
                    try {
                      print('Here');
                      final result = await getBatteryLevel();
                      print('Result: $result');
                      setState(() {
                        batteryLevel = result;
                      });
                    } catch (error) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text(error.message as String),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}