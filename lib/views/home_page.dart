import 'package:demo_bloc_arch/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/user_bloc/user_bloc.dart';
import '../controller/user_bloc/user_events.dart';
import '../controller/user_bloc/user_states.dart';
import '../controller/user_repository/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserBloc(UserRepository())..add(UserSubmittingEvent()),
      child: BlocProvider(create: (context) => UserBloc(UserRepository())..add(UserSubmittedEvent()),
        child: Scaffold(
              appBar: AppBar(
                title: const Text("Bloc Demo"),
              ),
              body: BlocSelector<UserBloc, UserStates, bool>(
                selector: (state){
                  print("State print $state");
                   return state is UserErrorState ? true : false;
                },
                builder: (context, state){
                  return BlocBuilder<UserBloc, UserStates>(
                      builder: (context, state){
                        if(state is UserLoadingState || state is UserInitialState){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        else if(state is UserSuccessState){
                          List<UserModel> users = state.users;
                          return state.users.isEmpty ? Container(color: Colors.pink,) : ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(backgroundImage: NetworkImage("${users[index].avatar}"), ),
                                        const SizedBox(width: 20,),
                                        Text("${users[index].firstName} ${users[index].lastName}"),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Text("${users[index].email}"),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if(state is UserErrorState){
                          return Text("${state.error}");
                        }
                        return const SizedBox();
                  });
                }
              ),
              ),
          ),
    );
  }
}