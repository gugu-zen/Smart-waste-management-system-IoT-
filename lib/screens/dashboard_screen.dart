import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; 
import 'package:smart_waste_management_system/model/bin_data.dart'; 
import 'package:smart_waste_management_system/services/thingspeak_service.dart'; 

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
                  // GarbageLevelsChart(binDataList: binDataList),
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

// class GarbageLevelsChart extends StatelessWidget {
//   final List<BinData> binDataList;

//   GarbageLevelsChart({required this.binDataList});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Garbage Levels Over Time',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Container(
//               height: 200.0,
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(
//                     bottomTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 22,
//                       getTextStyles: (context, value) => const TextStyle(
//                         color: Color(0xff68737d),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                       margin: 10,
//                       getTitles: (value) {
//                         return '${value.toInt()}'; // Replace with your actual data labels
//                       },
//                     ),
//                     leftTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 28,
//                       getTextStyles: (context, value) => const TextStyle(
//                         color: Color(0xff67727d),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                       getTitles: (value) {
//                         return '${value.toInt()}%'; // Replace with your actual data labels
//                       },
//                       margin: 12,
//                     ),
//                   ),
//                   borderData: FlBorderData(
//                     show: true,
//                     border: Border.all(
//                       color: const Color(0xff37434d),
//                       width: 1,
//                     ),
//                   ),
//                   minX: 0,
//                   maxX: binDataList.length.toDouble() - 1,
//                   minY: 0,
//                   maxY: 100,
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: binDataList.asMap().entries.map((entry) {
//                         return FlSpot(entry.key.toDouble(), entry.value.garbageLevel);
//                       }).toList(),
//                       isCurved: true,
//                       colors: [Colors.blue],
//                       barWidth: 4,
//                       isStrokeCapRound: true,
//                       dotData: FlDotData(show: false),
//                       belowBarData: BarAreaData(show: false),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
                _getColorForLevel(binData.garbageLevel),
              ),
            ),
            trailing: Text('${binData.garbageLevel.toStringAsFixed(2)}%'),
          ),
        );
      }).toList(),
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
