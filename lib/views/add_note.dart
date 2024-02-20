import 'package:assignment/controllers/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addNote(context);
              },
              child: Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }

  void _addNote(BuildContext context) {

    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      Note newNote = Note(
        id: 0, // Set to 0 as it's usually auto-incremented in databases
        title: _titleController.text,
        content: _contentController.text,
      );

      BlocProvider.of<NoteBloc>(context).add(AddNoteEvent(newNote));
      Navigator.pop(context); // Go back to the previous screen
    } else {
      // Show an error or prompt the user to fill in both title and content
    }
  }
}
