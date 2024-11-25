import 'package:flutter_bloc/flutter_bloc.dart';

import '../user_repository/user_repository.dart';
import 'user_events.dart';
import 'user_states.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitialState()) {
    on<UserSubmittedEvent>((event, emit) async {
      if(event is UserSubmittingEvent){
        emit(UserLoadingState());
      } else {
        try {
        final users = await userRepository.getUsers();
        emit(UserSuccessState(users: users));
      } catch(e){
        emit(UserErrorState(error: e.toString()));
      }
      }
    });
  }
}