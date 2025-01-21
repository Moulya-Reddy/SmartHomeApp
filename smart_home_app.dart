//Code:
import 'package:flutter/material.dart';

void main() {
  runApp(SmartHomeControlApp());
}

class SmartHomeControlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Control',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> devices = [];

  void addDevice(String name) {
    setState(() {
      devices.add({'name': name, 'isOn': false});
    });
  }

  void toggleDevice(int index) {
    setState(() {
      devices[index]['isOn'] = !devices[index]['isOn'];
    });
  }

  void showAddDeviceDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Device'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter device name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                addDevice(controller.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home Control'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: showAddDeviceDialog,
            child: Text('Add Device'),
          ),
          Expanded(
            child: devices.isEmpty
                ? Center(child: Text('No devices added'))
                : ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(devices[index]['name']),
                        subtitle: Text(
                          devices[index]['isOn'] ? 'Status: ON' : 'Status: OFF',
                        ),
                        trailing: Switch(
                          value: devices[index]['isOn'],
                          onChanged: (value) {
                            toggleDevice(index);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
