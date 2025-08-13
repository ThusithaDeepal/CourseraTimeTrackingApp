import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:time_tracker/models/project.dart';
import 'package:time_tracker/models/task.dart';
import 'package:time_tracker/models/time_entry.dart';

class TimeEntryProvider with ChangeNotifier {
  List<TimeEntry> _entries = [];

  List<TimeEntry> get entries => _entries;

  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    localStorage.setItem(
      "timeEntries",
      jsonEncode(entries.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    localStorage.setItem(
      "timeEntries",
      jsonEncode(entries.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }
}

class ProjectTaskProvider extends ChangeNotifier {
  final List<Project> _projects = [];
  List<Project> get projects => _projects;
  Future<void> addProjectEntry(Project projectEntry) async {
    _projects.add(projectEntry);

    localStorage.setItem("projects", Project.projectsToJson(_projects));
    notifyListeners();
  }

  void deleteProjectEntry(String id) {
    _projects.removeWhere((entry) => entry.id == id);
    localStorage.setItem("projects", Project.projectsToJson(_projects));
    notifyListeners();
  }

  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  void addProjectTasks(Task taskEntry) {
    _tasks.add(taskEntry);
    localStorage.setItem("tasks", Task.listToJson(_tasks));
    notifyListeners();
  }

  void deleteTaskEntry(String id) {
    _tasks.removeWhere((entry) => entry.id == id);
    localStorage.setItem("tasks", Task.listToJson(_tasks));
    notifyListeners();
  }
}
