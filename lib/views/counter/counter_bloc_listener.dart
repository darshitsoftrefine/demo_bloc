import 'package:demo_bloc_arch/controller/counter_bloc/counter_bloc.dart';
import 'package:demo_bloc_arch/controller/counter_bloc/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/counter_bloc/counter_events.dart';

class Counter_Bloc_Listener extends StatefulWidget {
  const Counter_Bloc_Listener({super.key});

  @override
  State<Counter_Bloc_Listener> createState() => _Counter_Bloc_ListenerState();
}

class _Counter_Bloc_ListenerState extends State<Counter_Bloc_Listener> {

  int counter = 0;
  bool consumer = false;
  bool builder = false;
  bool selector = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Bloc Listener Demo"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocListener<CounterBloc, CounterState>(
                listener: (context, state) {
                  if(state.counter >= 2){
                    showDialog(context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(title: Text("Hello ${state.counter}"),);
                      },
                    );
                  }
                },
                child: Column(
                  children: [
                    Text("Bloc Listener"),
                    Row(
                      children: [
                        FloatingActionButton(onPressed: (){
                          context.read<CounterBloc>().add(CounterIncrementEvent());
                        }, child: Icon(Icons.add),),
                        SizedBox(width: 20,),
                        FloatingActionButton(onPressed: (){
                          context.read<CounterBloc>().add(CounterDecrementEvent());
                        }, child: Icon(Icons.remove),)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}