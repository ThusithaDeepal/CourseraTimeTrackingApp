class TimeEntry {
  final String id;
  final String projectId;
  final String taskId;
  final double totalTime;
  final DateTime date;
  final String notes;
  TimeEntry({
    required this.id,
    required this.projectId,
    required this.taskId,
    required this.totalTime,
    required this.date,
    required this.notes,
  });

  // Convert object to Map
  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'taskId': taskId,
    'totalTime': totalTime,
    'date': date.toIso8601String(),
    'notes': notes,
  };

  // Optional: Convert Map to object
  factory TimeEntry.fromJson(Map<String, dynamic> json) => TimeEntry(
    projectId: json['projectId'],
    taskId: json['taskId'],
    totalTime: json['totalTime'],
    date: DateTime.parse(json['date']),
    notes: json['notes'],
    id: json['id'],
  );
}
