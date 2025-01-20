import 'package:ecom_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserLoading()) {

    // Add user.
    on<FetchUser>(
      (event, emit) async {
        emit(UserLoading());
        try {
          // Fetch the users from the API.
          final user = await userRepository.fetchUserData();
          emit(UserUpdated(user));
        } catch (e) {
          emit(
            UserError('Failed to fetch user'),
          );
        }
      },
    );

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
