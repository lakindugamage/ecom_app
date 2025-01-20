import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    // Add user.
    on<AddUser>((event, emit) {
      emit(UserUpdated(event.user));
    });

    // Clear user.
    on<ClearUser>((event, emit) {
      emit(UserUpdated(null));
    });
  }
}
