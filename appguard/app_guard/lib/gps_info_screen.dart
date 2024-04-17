import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;

class LocationInfoScreen extends StatefulWidget {
  @override
  _LocationInfoScreenState createState() => _LocationInfoScreenState();
}

class _LocationInfoScreenState extends State<LocationInfoScreen> {
  location.Location locationService = location.Location();
  bool _serviceEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkLocationService();
  }

  Future<void> _checkLocationService() async {
    bool serviceEnabled = await locationService.serviceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabled;
    });

    if (serviceEnabled) {
      // Location service is enabled
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Service Reminder'),
            content: Text('Location service is currently enabled. '
                'Please turn it off if not in use to save battery.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800], // Orange[800] appbar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Button for Location Service
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), backgroundColor: _serviceEnabled
                    ? Colors.cyan[
                        600] // Slightly darker Blue if Location Service is Enabled
                    : Colors.blueGrey[
                        800], // Slightly darker BlueGrey[800] if Location Service is Disabled
                padding: EdgeInsets.all(
                    100), // Adjust the size of the button as needed
              ),
              child: Text(
                _serviceEnabled ? 'ON' : 'OFF',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white), // Larger text with white color
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _checkLocationService();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800], // Orange[800] button color
              ),
              child: Text('Check Location Service',
                  style: TextStyle(color: Colors.white)), // White text
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey[900], // BlueGrey[900] background color
    );
  }
}
