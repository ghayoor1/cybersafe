import 'package:flutter/material.dart';
import 'package:disk_space_update/disk_space_update.dart';
import 'package:system_info_plus/system_info_plus.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:permission_handler/permission_handler.dart';

class MemoryInfoScreen extends StatefulWidget {
  @override
  _MemoryInfoScreenState createState() => _MemoryInfoScreenState();
}

class _MemoryInfoScreenState extends State<MemoryInfoScreen> {
  double? _totalRAM;
  double _diskSpace = 0;
  double _totalDiskSpace = 0;
  List<AppInfo> _installedApps = [];
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _getDeviceMemory();
    await initDiskSpace();
    await _getInstalledApps();
  }

  Future<void> _getDeviceMemory() async {
    try {
      double totalRAM =
          (await SystemInfoPlus.physicalMemory ?? 0) / (1024); // Convert to GB
      print('Total RAM: $totalRAM GB');

      setState(() {
        _totalRAM = totalRAM;
      });
    } catch (e) {
      print('Error getting RAM: $e');
    }
  }

  Future<void> initDiskSpace() async {
    try {
      double diskSpace = await DiskSpace.getFreeDiskSpace ?? 0;
      double totalDiskSpace = await DiskSpace.getTotalDiskSpace ?? 0;

      setState(() {
        _diskSpace = diskSpace / (1024); // Convert to GB
        _totalDiskSpace = totalDiskSpace / (1024); // Convert to GB
      });
    } catch (e) {
      print('Error getting disk space: $e');
    }
  }

  Future<void> _getInstalledApps() async {
    var status = await Permission.storage.request();

    if (status.isGranted || status == PermissionStatus.permanentlyDenied) {
      try {
        List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);

        setState(() {
          _installedApps = apps;
          _dataFetched = true;
        });
      } catch (e) {
        print('Error getting installed apps: $e');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission Required'),
            content: Text(
              'Please grant storage permission to retrieve installed apps.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
        title: Text('Memory Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        color: Colors.blueGrey[900],
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[700],
                border: Border.all(
                  color: Colors.orange,
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Total RAM: ${_totalRAM?.toStringAsFixed(2) ?? 'N/A'} GB',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Free Space on device: ${_diskSpace.toStringAsFixed(2)} GB',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Total space on device: ${_totalDiskSpace.toStringAsFixed(2)} GB',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildAppList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppList() {
    if (!_dataFetched) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: _installedApps.map((appInfo) {
              return Card(
                color: Colors.blueGrey[700],
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.memory(appInfo.icon!),
                  ),
                  title: Text(
                    appInfo.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          InstalledApps.openSettings(appInfo.packageName);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange[400]),
                        ),
                        child: Text(
                          'See Permissions',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    InstalledApps.startApp(appInfo.packageName);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
