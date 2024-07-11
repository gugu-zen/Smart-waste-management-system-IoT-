import 'package:flutter/material.dart';
import 'package:smart_waste_management_system/model/bin_data.dart';


class BinDetailScreen extends StatelessWidget {
  final BinData binData;

  BinDetailScreen({required this.binData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bin Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Garbage Level: ${binData.garbageLevel} cm', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Timestamp: ${binData.timestamp}', style: TextStyle(fontSize: 16)),
            // Additional bin details can be added here
          ],
        ),
      ),
    );
  }
}
