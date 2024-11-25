import '../../model/user_model.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserSuccessState extends UserStates {
  final List<UserModel> users;
  UserSuccessState({required this.users});
}

class UserErrorState extends UserStates {
  final String error;
  UserErrorState({required this.error});

}

