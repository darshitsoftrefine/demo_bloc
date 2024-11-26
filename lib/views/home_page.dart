import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc/user_bloc.dart';
import '../bloc/user_bloc/user_events.dart';
import '../bloc/user_bloc/user_states.dart';
import '../model/user_model/user_model.dart';
import '../model/user_repository/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _scrollController = ScrollController();
  List<Data> users = [];
  List<Data> totalUsers = [];
  bool isLoadMore = false;
  int page = 1;

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
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadMore = true;
        page++;
        fetchData(context);
      });
    }
  }

  void fetchData(BuildContext context) {
    if (isLoadMore) {
      final userListBloc = context.read<UserBloc>();
      userListBloc.add(UserSubmittedEvent());
      if(page == 4) {
          isLoadMore = false;
         _scrollController.removeListener(_loadMore);
      }
      // setState(() {
      //   totalUsers.addAll(moreUsers);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
      return BlocProvider(create: (context) => UserBloc(UserRepository())..add(UserSubmittedEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Bloc Demo"),
          ),
          body: BlocBuilder<UserBloc, UserStates>(
              builder: (context, state){
                if(state is UserLoadingState || state is UserInitialState){
                  return const Center(child: CircularProgressIndicator(),);
                }
                else if(state is UserSuccessState){
                  users = state.users;

                    totalUsers.addAll(state.users);

                  print("Page number $page");
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: totalUsers.length + (isLoadMore ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if(index < totalUsers.length){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(backgroundImage: NetworkImage(totalUsers[index].avatar),),
                                      const SizedBox(width: 20,),
                                      Text("${totalUsers[index].firstName} ${totalUsers[index].lastName}"),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(totalUsers[index].email),
                                  const SizedBox(height: 20,),
                                  Text("${totalUsers[index].id}"),
                                ],
                              ),
                            ),
                          ),
                        );} else {
                        return isLoadMore ? const Padding(padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator(),),
                        ) : const Padding(padding: EdgeInsets.all(8.0),
                          child: Center(child: Text("No more data to load"),),
                        );
                      }
                    },
                  );
                } else if(state is UserErrorState){
                  return Center(child: Text(state.error));
                }
                return const Center(child: CircularProgressIndicator(),);
              }),
        ),
      );
  }
}