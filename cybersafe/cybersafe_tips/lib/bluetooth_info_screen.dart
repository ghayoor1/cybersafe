import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothInfoScreen extends StatefulWidget {
  @override
  _BluetoothInfoScreenState createState() => _BluetoothInfoScreenState();
}

class _BluetoothInfoScreenState extends State<BluetoothInfoScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  Future<void> _checkBluetoothState() async {
    final BluetoothState state = await FlutterBluetoothSerial.instance.state;
    setState(() {
      _bluetoothState = state;
    });

    if (_bluetoothState == BluetoothState.STATE_ON) {
      // Bluetooth is already turned on, notify the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Bluetooth is On'),
          content:
              Text('If not in use, consider turning it off to save battery.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else if (_bluetoothState == BluetoothState.STATE_OFF) {
      // Bluetooth is off, notify the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Bluetooth is Off'),
          content: Text('Consider turning it on if you need to use Bluetooth.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800], // Orange[800] appbar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Button for Bluetooth State
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), backgroundColor: _bluetoothState == BluetoothState.STATE_ON
                    ? Colors
                        .cyan[600] // Slightly darker Blue if Bluetooth is On
                    : Colors.blueGrey[
                        800], // Slightly darker BlueGrey[800] if Bluetooth is Off
                padding: EdgeInsets.all(
                    100), // Adjust the size of the button as needed
              ),
              child: Text(
                _bluetoothState == BluetoothState.STATE_ON ? 'ON' : 'OFF',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white), // Larger text with white color
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _checkBluetoothState();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800], // Orange[800] button color
              ),
              child: Text('Check Bluetooth State',
                  style: TextStyle(color: Colors.white)), // White text
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey[900], // BlueGrey[900] background color
    );
  }
}
