import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:network_info_plus/network_info_plus.dart';

class WifiInfoScreen extends StatefulWidget {
  @override
  _WifiInfoScreenState createState() => _WifiInfoScreenState();
}

class _WifiInfoScreenState extends State<WifiInfoScreen> {
  final NetworkInfo info = NetworkInfo();
  String? _wifiName = 'N/A';
  String? _wifiBSSID = 'N/A';
  String? _wifiIP = 'N/A';
  String? _wifiIPv6 = 'N/A';
  String? _wifiSubmask = 'N/A';
  String? _wifiBroadcast = 'N/A';
  String? _wifiGateway = 'N/A';

  @override
  void initState() {
    super.initState();
    _fetchWifiInfo();
  }

  Future<void> _fetchWifiInfo() async {
    if (await permission.Permission.locationWhenInUse.request().isGranted) {
      try {
        print('Fetching WiFi info...');
        _wifiName = await info.getWifiName();
        print('WiFi Name: $_wifiName');

        _wifiBSSID = await info.getWifiBSSID();
        print('WiFi BSSID: $_wifiBSSID');

        _wifiIP = await info.getWifiIP();
        print('WiFi IP Address: $_wifiIP');

        _wifiIPv6 = await info.getWifiIPv6();
        print('WiFi IPv6: $_wifiIPv6');

        _wifiSubmask = await info.getWifiSubmask();
        print('WiFi Submask: $_wifiSubmask');

        _wifiBroadcast = await info.getWifiBroadcast();
        print('WiFi Broadcast: $_wifiBroadcast');

        _wifiGateway = await info.getWifiGatewayIP();
        print('WiFi Gateway IP: $_wifiGateway');

        // Check for open Wi-Fi networks and notify the user
        _checkSecurity();

        setState(() {});
      } catch (e) {
        print('Error fetching WiFi info: $e');
      }
    } else {
      print('Location or Wi-Fi permission denied');
    }
  }

  void _checkSecurity() {
    // Check if the Wi-Fi network is open (no password)
    if (_wifiName != null && _wifiName!.toLowerCase().contains('open')) {
      // Display a warning to the user about an open Wi-Fi network
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Security Warning'),
          content: Text(
            'Connecting to an open Wi-Fi network is not secure. Please use a secure network.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
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
        title: Text('WiFi Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
      ),
      body: Container(
        color: Colors.blueGrey[900],
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange[800]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.blueGrey[700],
            ),
            margin: EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('WiFi Name: $_wifiName',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                Text('WiFi BSSID: $_wifiBSSID',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                Text('WiFi IP Address: $_wifiIP',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                Text('WiFi IPv6: $_wifiIPv6',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                Text('WiFi Submask: $_wifiSubmask',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                Text('WiFi Broadcast: $_wifiBroadcast',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                Text('WiFi Gateway IP: $_wifiGateway',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
