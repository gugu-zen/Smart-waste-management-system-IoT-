class BinData {
  final double garbageLevel;
  final DateTime timestamp;

  BinData({required this.garbageLevel, required this.timestamp});

  factory BinData.fromJson(Map<String, dynamic> json) {
    return BinData(
      garbageLevel: double.parse(json['field1']),
      timestamp: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'garbageLevel': garbageLevel,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
