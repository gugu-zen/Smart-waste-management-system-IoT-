import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                TrashCard(
                  title: 'Trash 1',
                  percentage: 20,
                  color: Colors.green,
                ),
                TrashCard(
                  title: 'Trash 2',
                  percentage: 50,
                  color: Colors.orange,
                ),
                TrashCard(
                  title: 'Trash 3',
                  percentage: 79,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrashCard extends StatelessWidget {
  final String title;
  final int percentage;
  final Color color;

  TrashCard({required this.title, required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: ListTile(
          leading: Icon(
            Icons.delete,
            color: color,
          ),
          title: Text(title),
          subtitle: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            color: color,
          ),
          trailing: Text('$percentage%'),
        ),
      ),
    );
  }
}
