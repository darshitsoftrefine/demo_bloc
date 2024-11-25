import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/user_bloc/user_bloc.dart';
import '../controller/user_bloc/user_events.dart';
import '../controller/user_bloc/user_states.dart';
import '../controller/user_repository/user_repository.dart';
import '../model/user_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  List<UserModel> users = [];

  @override
  void initState() {
    _scrollController.addListener(_loadMore);
    fetchData(context);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        fetchData(context);
      });
    }
  }

  void fetchData(BuildContext context) {
    if (mounted) {
      final userListBloc = context.read<UserBloc>();
      userListBloc.add(UserSubmittedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(UserRepository())..add(UserSubmittingEvent()),
      child: BlocProvider(
        create: (context) =>
            UserBloc(UserRepository())..add(UserSubmittedEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Bloc Demo"),
          ),
          body: BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
            if (state is UserLoadingState || state is UserInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserSuccessState) {
              return FutureBuilder(
                  future: UserRepository().getUsers(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    users = state.users;
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: _scrollController,
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          if(index < users.length){
                          return SizedBox(
                            height: 200,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(child: Image.network("${users[index].avatar}"),),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text("${users[index].firstName} ${users[index].lastName}"),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("${users[index].email}"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text("${snapshot.data?[index].id}"),
                                ],
                              ),
                            ),
                          );
                        } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        } 
                        );
                  });
            } else if (state is UserErrorState) {
              return Center(child: Text(state.error));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }
}
