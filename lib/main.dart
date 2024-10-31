import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class Note {
  final String title;
  final String content;

  Note({
    required this.title,
    required this.content,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  void _addNotes() {
    TextEditingController controller = TextEditingController();
    TextEditingController titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Write your note here'),
        ),
        actions: [
          MaterialButton(
              child: const Text('Save'),
              onPressed: () {
                if (controller.text.isNotEmpty ||
                    titleController.text.isNotEmpty) {
                  setState(() {
                    notes.add(
                      Note(
                        title: titleController.text,
                        content: controller.text,
                      ),
                    );
                    controller.clear();
                    titleController.clear();
                  });
                  Navigator.of(context).pop();
                }
              })
        ],
      ),
    );
  }

  void _onCardTap(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notes[index].title),
        content: Text(notes[index].content),
        actions: [
          MaterialButton(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          MaterialButton(
            child: const Text('Delete'),
            onPressed: () => setState(
              () {
                notes.removeAt(index);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              onTap: () => _onCardTap(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
