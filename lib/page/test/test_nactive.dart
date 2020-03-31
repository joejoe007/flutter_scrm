import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestNactive extends StatefulWidget {
  TestNactive({Key key}) : super(key: key);

  @override
  _TestNactiveState createState() {
    return _TestNactiveState();
  }
}

class _TestNactiveState extends State<TestNactive> {
  /// flutter 调用原生
  static const platform = const MethodChannel('com.czh.flutter.jumptoscan');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      batteryLevel = await platform.invokeMethod('getBatteryLevel');

    } on PlatformException catch (e) {

    }

    setState(() {
      _batteryLevel = batteryLevel;
    });

  }


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('牙疼'),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('获取车牌'),
                onPressed: _getBatteryLevel,
              ),

              Text(_batteryLevel),
            ],
          ),
        ),
      ),
    );
  }
}