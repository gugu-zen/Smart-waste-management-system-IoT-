import 'package:flutter/material.dart';
import 'package:smart_waste_management_system/model/bin_data.dart';
import 'package:smart_waste_management_system/services/thingspeak_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BinData> binDataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      ThingSpeakService service = ThingSpeakService();
      List<BinData> data = await service.getData();
      setState(() {
        binDataList = data;
      });
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

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
            onPressed: () {
              // Handle notifications
            },
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
            child: ListView.builder(
              itemCount: binDataList.length,
              itemBuilder: (context, index) {
                return TrashCard(
                  title: 'Trash',
                  level: binDataList[index].garbageLevel.toInt(),
                  color: _getColorForLevel(binDataList[index].garbageLevel),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForLevel(double level) {
    if (level < 30) {
      return Colors.green;
    } else if (level < 70) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

class TrashCard extends StatelessWidget {
  final String title;
  final int level;
  final Color color;

  TrashCard({required this.title, required this.level, required this.color});

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
            value: level / 100,
            backgroundColor: Colors.grey[200],
            color: color,
          ),
          trailing: Text('$level%'),
        ),
      ),
    );
  }
}
