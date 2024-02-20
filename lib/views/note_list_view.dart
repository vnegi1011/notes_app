import 'package:assignment/views/api_call_view.dart';
import 'package:assignment/views/view_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/note_controller.dart';
import 'add_note.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({super.key});

  @override
  Widget build(BuildContext context) {
    //final noteBloc = BlocProvider.of<NoteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 0.6))
              ),
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NotesLoadedState) {
                    final notes = state.notes;
                    if(notes.isEmpty){
                      return Center(child: Text('Empty. Try to add node.'),);
                    }
                    return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return Card(
                          child: ListTile(
                            title: Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
                            subtitle: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis,),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNote(note: note),));
                              // Handle tapping on a note
                            },
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ApiCallView(),));
              },
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))
              ),
              textColor: Colors.white,
              child: Text('API call')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a screen for adding a new note
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNote()),
          );        },
        child: Icon(Icons.add),
      ),
    );
  }
}
