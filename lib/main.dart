import 'package:demo_bloc_arch/controller/counter_bloc/counter_bloc.dart';
import 'package:demo_bloc_arch/views/counter/counter_page.dart';
import 'package:demo_bloc_arch/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/user_bloc/user_bloc.dart';
import 'controller/user_repository/user_repository.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => UserBloc(UserRepository())),
      BlocProvider(create: (context) => CounterBloc()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterPage()
    );
  }
}