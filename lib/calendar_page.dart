import 'package:calendar/addtask.dart';
import 'package:calendar/dashboard.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TaskScheduler();
  }
}

class TaskScheduler extends StatefulWidget {
  @override
  _TaskSchedulerState createState() => _TaskSchedulerState();
}

class _TaskSchedulerState extends State<TaskScheduler> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> tasks = [];

  void _addTask(Map<String, String> task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(235, 36, 105, 62),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
              )
            : Text('Task Scheduler'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTask(onAddTask: _addTask)),
                    );
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: _addDateBar(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Tasks',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(child: Text('No data available', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
                : ListView(
                    children: tasks.map((task) {
                      return _buildTask(
                        task['title']!,
                        '${task['date']} ${task['startTime']} - ${task['endTime']}',
                        task['category']!,
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 8),
      child: DatePicker(
        DateTime.now(),
        height: 90,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: const Color.fromARGB(235, 36, 105, 62),
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(235, 36, 105, 62),
        ),
      ),
    );
  }

  Widget _buildTask(String title, String subtitle, String category) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(category),
      ),
    );
  }
}
