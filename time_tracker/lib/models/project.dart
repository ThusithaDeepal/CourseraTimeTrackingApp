import 'dart:convert';

class Project {
  final String id;
  final String name;
  Project({required this.id, required this.name});
  // Convert Project to Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  // Create Project from Map (decoded JSON)
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(id: json['id'], name: json['name']);
  }

  // Convert list of Project objects to JSON string
 static String projectsToJson(List<Project> projects) {
  return jsonEncode(projects.map((p) => p.toJson()).toList());
}

// Convert JSON string back to List<Project>
static List<Project> projectsFromJson(String jsonString) {
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((item) => Project.fromJson(item)).toList();
}
}


