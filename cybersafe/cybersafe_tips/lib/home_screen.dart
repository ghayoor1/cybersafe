// Import necessary packages and screens
import 'package:flutter/material.dart';
import 'memory_info_screen.dart';
import 'battery_info_screen.dart';
import 'wifi_info_screen.dart';
import 'gps_info_screen.dart';
import 'bluetooth_info_screen.dart';
import 'caution_info_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen',
            style: TextStyle(color: Colors.white)), // Set app bar text color
        backgroundColor: Colors.orange[800], // Set app bar color
      ),
      body: Container(
        color: Colors.blueGrey[900], // Set background color of the whole screen
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            buildIcon(context, Icons.wifi, 'Wifi', WifiInfoScreen()),
            buildIcon(
                context, Icons.battery_full, 'Battery', BatteryInfoScreen()),
            buildIcon(context, Icons.memory, 'Memory', MemoryInfoScreen()),
            buildIcon(
                context, Icons.gps_fixed, 'Location', LocationInfoScreen()),
            // Additional icons
            buildIcon(
                context, Icons.bluetooth, 'Bluetooth', BluetoothInfoScreen()),
            buildIcon(context, Icons.warning, 'Caution', CautionInfoScreen()),
          ],
        ),
      ),
    );
  }

  Widget buildIcon(
      BuildContext context, IconData icon, String label, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueGrey[800], // Set background color of the icon box
          border: Border.all(
              color: Colors.orange[800]!, width: 2), // Set border color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.cyan[400]), // Set icon color
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white, // Set text color
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
