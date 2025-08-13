import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/project.dart';
import 'package:time_tracker/models/task.dart';
import 'package:time_tracker/provider/project_task_provider.dart';
// import 'models/project.dart';
// import 'models/task.dart';
// import 'providers/project_task_provider.dart';

class ProjectTaskManagementScreen extends StatefulWidget {
  bool isFromProject;
  ProjectTaskManagementScreen({required this.isFromProject});
  @override
  State<ProjectTaskManagementScreen> createState() =>
      _ProjectTaskManagementScreenState();
}

class _ProjectTaskManagementScreenState
    extends State<ProjectTaskManagementScreen> {
  TextEditingController controller = TextEditingController();
  void addProjectTask() {
    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          child: AlertDialog(
            title: widget.isFromProject
                ? Text("Add Project")
                : Text("Add Task"),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [TextFormField(controller: controller)],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  widget.isFromProject
                      ? context.read<ProjectTaskProvider>().addProjectEntry(
                          Project(id: controller.text, name: controller.text),
                        )
                      : context.read<ProjectTaskProvider>().addProjectTasks(
                          Task(id: controller.text, name: controller.text),
                        );
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Projects and Tasks')),
      body: Consumer<ProjectTaskProvider>(
        builder: (context, provider, child) {
          return widget.isFromProject
              ? Column(
                  children: [
                    ...provider.projects.map((e) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      provider.deleteProjectEntry(e.id);
                                    },
                                    icon: Icon(color: Colors.red, Icons.delete),
                                  ),
                                  title: Text(e.name),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                )
              : Column(
                  children: [
                    ...provider.tasks.map((e) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      provider.deleteTaskEntry(e.id);
                                    },
                                    icon: Icon(color: Colors.red, Icons.delete),
                                  ),
                                  title: Text(e.name),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new project or task
          addProjectTask();
        },
        tooltip: widget.isFromProject ? 'Add Project' : 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
