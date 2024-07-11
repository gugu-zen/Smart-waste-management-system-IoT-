import 'package:flutter/material.dart';
import 'package:smart_waste_management_system/model/bin_data.dart'; // Assuming BinData is imported here
import 'package:smart_waste_management_system/services/thingspeak_service.dart'; // Adjust the import path as needed

class DashboardScreen extends StatelessWidget {
  final ThingSpeakService _thingSpeakService = ThingSpeakService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BinData>>(
        future: _thingSpeakService.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            // Data fetched successfully
            List<BinData> binDataList = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  GarbageLevelsChart(binDataList: binDataList),
                  SizedBox(height: 16.0),
                  BinStatusList(binDataList: binDataList),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class GarbageLevelsChart extends StatelessWidget {
  final List<BinData> binDataList;

  GarbageLevelsChart({required this.binDataList});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Garbage Levels Over Time',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // Implement your line chart here based on binDataList
            Container(
              height: 200.0,
              color: Colors.grey[200],
              child: Center(
                child: Text('Implement your line chart here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BinStatusList extends StatelessWidget {
  final List<BinData> binDataList;

  BinStatusList({required this.binDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: binDataList.map((binData) {
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Bin ${binData.garbageLevel}'),
            subtitle: LinearProgressIndicator(
              value: binData.garbageLevel / 100.0,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                binData.garbageLevel < 50
                    ? Colors.green
                    : binData.garbageLevel < 80
                        ? Colors.yellow
                        : Colors.red,
              ),
            ),
            trailing: Text('${binData.garbageLevel.toStringAsFixed(2)}%'),
          ),
        );
      }).toList(),
    );
  }
}
