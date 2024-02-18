import 'package:flutter/material.dart';

void main() {
  runApp(MyJournalApp());
}

class MyJournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Journal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: JournalHomePage(),
    );
  }
}

class JournalHomePage extends StatefulWidget {
  @override
  _JournalHomePageState createState() => _JournalHomePageState();
}

class _JournalHomePageState extends State<JournalHomePage> {
  List<JournalEntry> entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Entries'),
      ),
      backgroundColor: Color(0xFFE8FFFD),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(entries[index].title),
            subtitle: Text(entries[index].body),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JournalEntryDetailPage(entry: entries[index]),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 56.0, // Adjust the height as needed
        color: Color(0xFFE8FFFD),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Action for home button
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddSchedulePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                // Action for search button
              },
            ),
            IconButton(
              icon: Icon(Icons.pie_chart),
              onPressed: () {
                // Action for settings button
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addJournalEntry() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddJournalEntryPage(),
      ),
    );

    if (result != null) {
      setState(() {
        entries.add(result);
      });
    }
  }
}

class AddJournalEntryPage extends StatefulWidget {
  @override
  _AddJournalEntryPageState createState() => _AddJournalEntryPageState();
}

class _AddJournalEntryPageState extends State<AddJournalEntryPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  double _mood = 5; // Default mood value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Journal Entry'),
      ),
      backgroundColor: Color(0xFFE8FFFD),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                labelText: 'Body',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            Text('How are you feeling today?'),
            Slider(
              value: _mood,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  _mood = value;
                });
              },
              label: _mood.round().toString(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveJournalEntry();
              },
              child: Text('Save'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Navigate back to the first page
                        },
                        child: Text('Back to First Page'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Action for the second button
                        },
                        child: Text('Button 2'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Action for the third button
                        },
                        child: Text('Button 3'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Action for the fourth button
                        },
                        child: Text('Button 4'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveJournalEntry() {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pop(
        context,
        JournalEntry(
          title: _titleController.text,
          body: _bodyController.text,
          mood: _mood.round(),
          date: DateTime.now(),
        ),
      );
    }
  }
}

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  late TimeOfDay _selectedTime = TimeOfDay.now();
  late String _selectedAction = 'Sleep';
  late String _selectedPriority = 'friends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Schedule'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TODAY FROM 00:00 TO:'),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(_formatTime(_selectedTime)),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _selectTime,
                  child: Text('Select Time', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFD1A9F7A), // Set button color
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('ACTION:'),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: _selectedAction,
              onChanged: (value) {
                setState(() {
                  _selectedAction = value!;
                });
              },
              items: <String>[
                'Sleep',
                'F&family',
                'Training',
                'Waste',
                'Duties',
                'school',
                'work',
                'irys',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text('PRIORITY:'),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: _selectedPriority,
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value!;
                });
              },
              items: <String>[
                'friends',
                'close friends',
                'personal',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity, // Make the button wide
              height: 40.0, // Make the button short
              child: ElevatedButton(
                onPressed: () {
                  // Action for the "Enter Activity" button
                },
                child: Text('Enter Activity', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFD1A9F7A), // Set button color
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          Navigator.pop(context); // Navigate back to the first page
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add_box),
                        onPressed: () {
                          // Action for the second button
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () {
                          // Action for the third button
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.pie_chart),
                        onPressed: () {
                          // Action for the fourth button
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}

class JournalEntryDetailPage extends StatelessWidget {
  final JournalEntry entry;

  JournalEntryDetailPage({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Entry'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditJournalEntryPage(entry: entry),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFD1A9F7A),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              entry.body,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Mood: ${entry.mood}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: ${entry.date}',
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

class EditJournalEntryPage extends StatefulWidget {
  final JournalEntry entry;

  EditJournalEntryPage({required this.entry});

  @override
  _EditJournalEntryPageState createState() => _EditJournalEntryPageState();
}

class _EditJournalEntryPageState extends State<EditJournalEntryPage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  double _mood = 5; // Default mood value

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry.title);
    _bodyController = TextEditingController(text: widget.entry.body);
    _mood = widget.entry.mood.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Journal Entry'),
      ),
      backgroundColor: Color(0xFFE8FFFD),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                labelText: 'Body',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            Text('How are you feeling today?'),
            Slider(
              value: _mood,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  _mood = value;
                });
              },
              label: _mood.round().toString(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveEditedJournalEntry();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveEditedJournalEntry() {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pop(
        context,
        JournalEntry(
          title: _titleController.text,
          body: _bodyController.text,
          mood: _mood.round(),
          date: widget.entry.date, // Keep the original date
        ),
      );
    }
  }
}

class JournalEntry {
  final String title;
  final String body;
  final int mood;
  final DateTime date;

  JournalEntry({required this.title, required this.body, required this.mood, required this.date});
}
