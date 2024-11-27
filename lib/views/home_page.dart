import 'package:cached_network_image/cached_network_image.dart';
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

  ScrollController _scrollController = ScrollController();
  List<Data> users = [];
  bool isLoadMore = false;
  int page = 1;

  @override
  void initState() {
    _scrollController.addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchData();
    }
  }

  Future<void> fetchData() async{
    if (isLoadMore) return;
    setState(() {
      isLoadMore = true;
    });
    setState(() {
      page++;
      isLoadMore = false;
      final userListBloc = context.read<UserBloc>();
      userListBloc.add(UserSubmittedEvent(pageNumber: page));
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Bloc Demo"),
          ),
          body: BlocProvider(create: (context) => UserBloc(userRepository: UserRepository())..add(UserSubmittedEvent(pageNumber: page)),
            child: BlocBuilder<UserBloc, UserStates>(
                builder: (context, state){
                  print("State $state");
                  if(state is UserLoadingState || state is UserInitialState){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  else if(state is UserSuccessState){
                    //users.clear();
                    users = users + state.users;

                    print("Users ${state.users[0].firstName}");
                    print("Page number $page");
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        if(index < users.length){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(child: CachedNetworkImage(imageUrl:  users[index].avatar, progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),),),
                                        const SizedBox(width: 20,),
                                        Text("${users[index].firstName} ${users[index].lastName}"),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(users[index].email),
                                    const SizedBox(height: 20,),
                                    Text("${users[index].id}"),
                                  ],
                                ),
                              ),
                            ),
                          );} else {
                          return isLoadMore ? const Padding(padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator(),),
                          ) : const Text("No more data");
                        }
                      },
                    );
                  } else if(state is UserErrorState){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(state.error)),
                    );
                  }
                  return const Center(child: CircularProgressIndicator(),);
                }
                    ),
          ),
      );
  }
}