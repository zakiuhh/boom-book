class ReadingStatistics {
  final int totalBooksRead;
  final int totalReadingMinutes;
  final Map<String, int> dailyReadingMinutes; // date -> minutes
  final DateTime lastReadDate;

  ReadingStatistics({
    required this.totalBooksRead,
    required this.totalReadingMinutes,
    required this.dailyReadingMinutes,
    required this.lastReadDate,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalBooksRead': totalBooksRead,
      'totalReadingMinutes': totalReadingMinutes,
      'dailyReadingMinutes': dailyReadingMinutes,
      'lastReadDate': lastReadDate.toIso8601String(),
    };
  }

  // Create from JSON
  factory ReadingStatistics.fromJson(Map<String, dynamic> json) {
    return ReadingStatistics(
      totalBooksRead: json['totalBooksRead'] ?? 0,
      totalReadingMinutes: json['totalReadingMinutes'] ?? 0,
      dailyReadingMinutes: Map<String, int>.from(json['dailyReadingMinutes'] ?? {}),
      lastReadDate: json['lastReadDate'] != null
          ? DateTime.parse(json['lastReadDate'])
          : DateTime.now(),
    );
  }

  // Get formatted total reading time
  String get formattedTotalTime {
    if (totalReadingMinutes < 60) {
      return '$totalReadingMinutes min';
    }
    final hours = totalReadingMinutes ~/ 60;
    final minutes = totalReadingMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  // Get reading data for last N days
  Map<String, int> getLastDaysData(int days) {
    final result = <String, int>{};
    final now = DateTime.now();
    
    for (int i = 0; i < days; i++) {
      final date = now.subtract(Duration(days: i));
      final dateKey = _formatDate(date);
      result[dateKey] = dailyReadingMinutes[dateKey] ?? 0;
    }
    
    return result;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Create empty statistics
  factory ReadingStatistics.empty() {
    return ReadingStatistics(
      totalBooksRead: 0,
      totalReadingMinutes: 0,
      dailyReadingMinutes: {},
      lastReadDate: DateTime.now(),
    );
  }
}
