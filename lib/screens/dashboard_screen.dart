import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SummaryCards(),
            SizedBox(height: 16.0),
            GarbageLevelsChart(),
            SizedBox(height: 16.0),
            CollectionEfficiencyChart(),
            SizedBox(height: 16.0),
            BinStatusList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Bins',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 1, // Dashboard is the active tab
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class SummaryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SummaryCard(
          title: 'Total Bins',
          value: '50',
          icon: Icons.delete,
          color: Colors.blue,
        ),
        SummaryCard(
          title: 'Full Bins',
          value: '10',
          icon: Icons.warning,
          color: Colors.red,
        ),
        SummaryCard(
          title: 'Collected Bins',
          value: '30',
          icon: Icons.check_circle,
          color: Colors.green,
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40.0, color: color),
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
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
    {'name': 'Bin 2', 'level': 50},
    {'name': 'Bin 3', 'level': 90},
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
