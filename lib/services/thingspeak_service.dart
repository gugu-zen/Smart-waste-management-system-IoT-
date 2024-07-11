import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_waste_management_system/model/bin_data.dart';

class ThingSpeakService {
  final String readApiKey = 'H8M68IKI5A3QYVET';
  final String channelId = '2595920';

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
