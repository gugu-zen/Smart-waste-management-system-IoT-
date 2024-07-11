import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:smart_waste_management_system/model/bin_data.dart';


class ThingSpeakService {
  final String writeApiKey = '83IIZRVL7PG7EPZD';
  final String readApiKey = 'MXT9IPB64W8UZEXM';
  final String channelId = '2595954';

  Future<void> sendData(double garbageLevel, Position position) async {
    final url = Uri.parse('https://api.thingspeak.com/update?api_key=$writeApiKey&field1=$garbageLevel&latitude=${position.latitude}&longitude=${position.longitude}');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to send data to ThingSpeak');
    }
  }

  Future<List<BinData>> getData() async {
    final url = Uri.parse('https://api.thingspeak.com/channels/$channelId/feeds.json?api_key=$readApiKey&results=2');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List feeds = json.decode(response.body)['feeds'];
      return feeds.map((feed) => BinData.fromJson(feed)).toList();
    } else {
      throw Exception('Failed to fetch data from ThingSpeak');
    }
  }
}
