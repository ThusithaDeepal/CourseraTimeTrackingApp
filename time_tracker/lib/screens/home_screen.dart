import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/time_entry.dart';
import 'package:time_tracker/provider/project_task_provider.dart';
import 'package:time_tracker/screens/project_task_management.dart';
import 'package:time_tracker/screens/time_entry_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  Widget allEntryWidget() {
    return Container(
      child: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return provider.entries.isEmpty
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.no_accounts, color: Colors.blue, size: 40),
                      SizedBox(width: 10),
                      Text(
                        "No Time Entries Click + To Add",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: provider.entries.length,
                  itemBuilder: (context, index) {
                    final entry = provider.entries[index];
                    return Container(
                      color: Colors.blue.shade100,
                      margin: EdgeInsets.only(bottom: 5),
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            provider.deleteTimeEntry(
                              provider.entries[index].id,
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                        title: Text(
                          '${entry.projectId} - ${entry.totalTime} hours',
                        ),
                        subtitle: Text(
                          '${entry.date.toString()} - Notes: ${entry.notes}',
                        ),
                        onTap: () {
                          // This could open a detailed view or edit screen
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget groupProjectWidget() {
    List<TimeEntry> entryList = context.read<TimeEntryProvider>().entries;

    final Map<String, List<TimeEntry>> grouped = entryList.groupListsBy(
      (element) => element.projectId,
    );
    return Container(
      child: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return provider.entries.isEmpty
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.no_accounts, color: Colors.blue, size: 40),
                      SizedBox(width: 10),
                      Text(
                        "No Time Entries Click + To Add",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: [
                    ...grouped.entries.map((ele) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.amber.shade100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ele.key,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: ele.value.map((item) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("TaskId: ${item.taskId}"),
                                                Text(
                                                  "Task total time: ${item.totalTime.toString()}",
                                                ),
                                                Text(
                                                  "Task total time: ${item.date.toString()}",
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeEntryProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Time Entries')),
          drawer: SafeArea(
            child: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.yellow),
                    child: Center(child: Text("Menu")),
                  ),
                  ListTile(
                    title: Text("Project"),
                    leading: Icon(Icons.file_copy, color: Colors.red),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProjectTaskManagementScreen(
                              isFromProject: true,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Tasks"),
                    leading: Icon(Icons.task, color: Colors.amber),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProjectTaskManagementScreen(
                              isFromProject: false,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                TabBar(
                  controller: _controller,
                  tabs: [
                    Text(
                      "All Entries",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    Text(
                      "Group by Project",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [allEntryWidget(), groupProjectWidget()],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigate to the screen to add a new time entry
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTimeEntryScreen()),
              );
            },
            child: Icon(Icons.add),
            tooltip: 'Add Time Entry',
          ),
        );
      },
    );
  }
}
