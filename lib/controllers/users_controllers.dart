import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/api_service.dart';

// Events
abstract class UserEvent {}

class FetchUsers extends UserEvent {}

// States
abstract class UserState {}

class UserInitial extends UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<Map<String, dynamic>> users;

  UsersLoaded(this.users);
}

class UsersError extends UserState {
  final String error;

  UsersError(this.error);
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService _apiService = ApiService();

  UserBloc() : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UsersLoading());
      try {
        final users = await _apiService.getUsers();
        emit(UsersLoaded(users));
      } catch (error) {
        emit(UsersError('Failed to load users: $error'));
      }
    });
  }
}
