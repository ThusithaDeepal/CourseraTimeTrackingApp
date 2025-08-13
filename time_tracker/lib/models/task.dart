import 'dart:convert';

class Task {
  final String id;
  final String name;
  Task({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
    );
  }

  /// Convert a List<Task> to JSON string
  static String listToJson(List<Task> tasks) {
    return jsonEncode(tasks.map((task) => task.toJson()).toList());
  }

  /// Convert JSON string to List<Task>
  static List<Task> listFromJson(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => Task.fromJson(item)).toList();
  }
}