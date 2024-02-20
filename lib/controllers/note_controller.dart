import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/note.dart';
import '../utils/database_helper.dart';

// Events
abstract class NoteEvent {}

class LoadNotesEvent extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final Note note;

  AddNoteEvent(this.note);
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;

  UpdateNoteEvent(this.note);
}

class DeleteNoteEvent extends NoteEvent {
  final int id;

  DeleteNoteEvent(this.id);
}

// States
abstract class NoteState {}

class NotesLoadedState extends NoteState {
  final List<Note> notes;

  NotesLoadedState(this.notes);
}

// BLoC
class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  NoteBloc() : super(NotesLoadedState([])) {
    on<LoadNotesEvent>((event, emit) async {
      emit(NotesLoadedState(await dbHelper.getNotes()));
    });

    on<AddNoteEvent>((event, emit) async {
      await dbHelper.insertNote(event.note);
      emit(NotesLoadedState(await dbHelper.getNotes()));
    });

    on<UpdateNoteEvent>((event, emit) async {
      await dbHelper.updateNote(event.note);
      emit(NotesLoadedState(await dbHelper.getNotes()));
    });

    on<DeleteNoteEvent>((event, emit) async {
      await dbHelper.deleteNote(event.id);
      emit(NotesLoadedState(await dbHelper.getNotes()));
    });
  }
}
