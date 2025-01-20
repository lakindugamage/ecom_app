import 'package:ecom_app/models/user.dart';

abstract class UserState {}

class UserEmpty extends UserState {}

// Loading the user.
class UserLoading extends UserState {}

// Updating the user.
class UserUpdated extends UserState {
  final User? users;

  UserUpdated(this.users);
}

// Error message from the uer.
class UserError extends UserState {
  final String message;

  UserError(this.message);
}
