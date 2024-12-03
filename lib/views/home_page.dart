import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc/user_bloc.dart';
import '../bloc/user_bloc/user_events.dart';
import '../bloc/user_bloc/user_states.dart';
import '../model/user_model/user_model.dart';

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
  String error = "";

  @override
  void initState() {
    _scrollController.addListener(_loadMore);
    fetchMoreUsers();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      page++;
      fetchMoreUsers();
    }
  }

  void fetchMoreUsers() {
    final userListBloc = context.read<UserBloc>();
    userListBloc.add(UserSubmittedEvent(pageNumber: page));
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Bloc Demo"),
          ),
          body: BlocListener<UserBloc, UserStates>(
            listener: (context, state) {
              if(state is UserSuccessState) {
                isLoadMore = false;
                users.addAll(state.users);
              } else if(state is UserErrorState){
                error = state.error;
              } else if(state is UserLoadingState || state is UserInitialState){
                isLoadMore = true;
              }
            },
              child : BlocBuilder<UserBloc, UserStates>(
              builder: (context, state){
                  return error == "" ? Stack(
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            var userData = users[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(child: CachedNetworkImage(imageUrl: userData.avatar,
                                              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),),),
                                          const SizedBox(width: 20,),
                                          Text("${userData.firstName} ${userData.lastName}"),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(userData.email),
                                      const SizedBox(height: 20,),
                                      Text("${userData.id}"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                      if(isLoadMore) const Center(child: CircularProgressIndicator(),)
                    ],
                  ) : Center(child: Text(error),);
                })
          ),
      );
  }
}