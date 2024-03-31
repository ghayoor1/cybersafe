import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BatteryInfoScreen extends StatefulWidget {
  @override
  _BatteryInfoScreenState createState() => _BatteryInfoScreenState();
}

class _BatteryInfoScreenState extends State<BatteryInfoScreen> {
  Battery _battery = Battery();
  BatteryState _batteryState = BatteryState.unknown;
  int _batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    _initBatteryInfo();
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
        // If charging, update battery level as well
        if (_batteryState == BatteryState.charging) {
          _updateBatteryLevel();
        }
      });
    });
  }

  Future<void> _initBatteryInfo() async {
    try {
      _updateBatteryLevel();
    } catch (e) {
      print('Error getting battery info: $e');
    }
  }

  Future<void> _updateBatteryLevel() async {
    int batteryLevel = await _battery.batteryLevel;
    BatteryState batteryState = await _battery.batteryState;

    setState(() {
      _batteryLevel = batteryLevel;
      _batteryState = batteryState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.blueGrey[900],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width * 0.4,
                lineWidth: 15.0,
                percent: (_batteryState == BatteryState.charging)
                    ? 1.0
                    : (_batteryLevel / 100.0),
                center: Text(
                  '$_batteryLevel%',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                progressColor: Colors.cyan[400],
                backgroundColor: Colors.grey,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange[800]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueGrey[700],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.battery_full, color: Colors.white),
                        SizedBox(height: 8),
                        Text('Charging State',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Text(_getChargingStatus(),
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange[800]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueGrey[700],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.battery_alert, color: Colors.white),
                        SizedBox(height: 8),
                        Text('Battery Level',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Text(
                          '$_batteryLevel%',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getChargingStatus() {
    return _getChargingStatusText(_batteryState);
  }

  String _getChargingStatusText(BatteryState state) {
    switch (state) {
      case BatteryState.charging:
        return 'Charging';
      case BatteryState.discharging:
        return 'Not Charging';
      case BatteryState.full:
        return 'Full';
      default:
        return 'Unknown';
    }
  }
}
