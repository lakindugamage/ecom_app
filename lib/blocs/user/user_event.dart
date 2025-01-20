
import 'package:ecom_app/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

// Add user.
class AddUser extends UserEvent {
  final User user;

  AddUser(this.user);

  @override
  List<Object?> get props => [user];
}

// Clear user.
class ClearUser extends UserEvent {}
