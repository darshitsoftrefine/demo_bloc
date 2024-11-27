import '../../model/user_model/user_model.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserSuccessState extends UserStates {
  List<Data> users;
  UserSuccessState({required this.users});
}

class UserErrorState extends UserStates {
  final String error;
  UserErrorState({required this.error});

}

