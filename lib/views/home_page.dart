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

  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_loadMore);
    UserRepository().getUsers();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      UserRepository().getUsers;
    }
  }

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
                            controller: _scrollController,
                            itemCount: users.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 200,
                                child: Card(
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
                                      const SizedBox(height: 20,),
                                      Text("${users[index].id}"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if(state is UserErrorState){
                          return Text(state.error);
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