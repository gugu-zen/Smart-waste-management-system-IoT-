import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            GarbageLevelsChart(),
            SizedBox(height: 16.0),
            CollectionEfficiencyChart(),
            SizedBox(height: 16.0),
            BinStatusList(),
          ],
        ),
      ),
    );
  }
}

class GarbageLevelsChart extends StatelessWidget {
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
            // Placeholder for line chart
            Container(
              height: 200.0,
              color: Colors.grey[200],
              child: Center(
                child: Text('Line Chart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CollectionEfficiencyChart extends StatelessWidget {
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
              'Collection Efficiency',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // Placeholder for bar chart
            Container(
              height: 200.0,
              color: Colors.grey[200],
              child: Center(
                child: Text('Bar Chart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BinStatusList extends StatelessWidget {
  final List<Map<String, dynamic>> bins = [
    {'name': 'Bin 1', 'level': 75},
    // Add more bins as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bins.map((bin) {
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(bin['name']),
            subtitle: LinearProgressIndicator(
              value: bin['level'] / 100.0,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                bin['level'] < 50
                    ? Colors.green
                    : bin['level'] < 80
                        ? Colors.yellow
                        : Colors.red,
              ),
            ),
            trailing: Text('${bin['level']}%'),
          ),
        );
      }).toList(),
    );
  }
}
