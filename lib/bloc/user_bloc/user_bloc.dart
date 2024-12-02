import 'package:demo_bloc_arch/model/user_model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/user_repository/user_repository.dart';
import 'user_events.dart';
import 'user_states.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on((event, emit) async {
      if(event is UserSubmittingEvent){
        emit(UserLoadingState());
      } else if(event is UserSubmittedEvent){
        try {
        List<Data> users = (await userRepository.getUsers(event.pageNumber)) as List<Data>;
      emit(UserSuccessState(users: users));
    } catch(e){
      emit(UserErrorState(error: e.toString()));
    }
      }
    });
  }
}