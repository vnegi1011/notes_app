
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/users_controllers.dart';

class ApiCallView extends StatefulWidget {
  const ApiCallView({super.key});

  @override
  State<ApiCallView> createState() => _ApiCallViewState();
}

class _ApiCallViewState extends State<ApiCallView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(BlocProvider.of<UserBloc>(context).state is! UsersLoaded || BlocProvider.of<UserBloc>(context).state is! UsersLoading){
      BlocProvider.of<UserBloc>(context).add(FetchUsers());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          // Add any logic here if needed when the state changes
          if(state is UsersError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed!')));
          }
        },
        builder: (context, state) {
          if (state is UserInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                );
              },
            );
          } else if (state is UsersError) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(FetchUsers());
                }, child: const Text('Retry'),
              ),
            );
          }else if(state is UsersLoading){
            return const Center(
              child: CircularProgressIndicator( color: Colors.green,),
            );
          }
          return const Center(
            child: Text('Unknown state'),
          );

        },
      ),
    );
  }
}
