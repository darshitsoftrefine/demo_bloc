import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';

abstract class UserStates extends Equatable {}

class UserInitialState extends UserStates {
  @override

  List<Object?> get props => [];
}

class UserLoadingState extends UserStates {
  @override

  List<Object?> get props => [];
}

class UserSuccessState extends UserStates {
  final List<UserModel> users;
  UserSuccessState(this.users);
  @override

  List<Object?> get props => [users];
}

class UserErrorState extends UserStates {
  final String error;
  UserErrorState(this.error);
  @override

  List<Object?> get props => [error];

}

