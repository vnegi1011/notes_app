import 'package:assignment/controllers/users_controllers.dart';
import 'package:assignment/views/note_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers/note_controller.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(
          create: (BuildContext context) => NoteBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteListView(),
    );
  }
}
