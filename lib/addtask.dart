import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  final Function(Map<String, String>) onAddTask;

  const AddTask({Key? key, required this.onAddTask}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TimeOfDay _startTime = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 12, minute: 0);
  List<String> categories = ['Meeting', 'Design', 'Calls'];
  String _selectedCategory = 'Meeting';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate = pickedDate.toLocal().toString().substring(0, 10);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (pickedTime != null) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (pickedTime != null) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final int hour = timeOfDay.hourOfPeriod;
    final int minute = timeOfDay.minute;
    final String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(235, 36, 105, 62),
        title: Text("Create a New Task"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Title"),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Enter title'),
            ),
            SizedBox(height: 10),
            Text("Description"),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Enter description'),
            ),
            SizedBox(height: 10),
            Text("Date"),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(hintText: 'Select date'),
              onTap: () async {
                FocusScope.of(context).unfocus();
                await _selectDate(context);
              },
              readOnly: true,
            ),
            SizedBox(height: 10),
            Text("Start Time"),
            GestureDetector(
              onTap: () => _selectStartTime(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: formatTimeOfDay(_startTime)),
                  decoration: InputDecoration(hintText: 'Select start time'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("End Time"),
            GestureDetector(
              onTap: () => _selectEndTime(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: formatTimeOfDay(_endTime)),
                  decoration: InputDecoration(hintText: 'Select end time'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Category"),
            DropdownButton<String>(
              value: _selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onAddTask({
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                  'date': _dateController.text,
                  'startTime': formatTimeOfDay(_startTime),
                  'endTime': formatTimeOfDay(_endTime),
                  'category': _selectedCategory,
                });
                Navigator.pop(context);
              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
