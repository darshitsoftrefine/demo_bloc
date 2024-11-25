import 'package:demo_bloc_arch/controller/counter_bloc/counter_bloc.dart';
import 'package:demo_bloc_arch/controller/counter_bloc/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/counter_bloc/counter_events.dart';

class Counter_Bloc_Builder extends StatefulWidget {
  const Counter_Bloc_Builder({super.key});

  @override
  State<Counter_Bloc_Builder> createState() => _Counter_Bloc_BuilderState();
}

class _Counter_Bloc_BuilderState extends State<Counter_Bloc_Builder> {

  int counter = 0;
  bool consumer = false;
  bool builder = false;
  bool selector = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Bloc Builder Demo"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Center(
                        child: Text("${state.counter.toString()}", style: TextStyle(fontSize: 15),),
                      ),
                      SizedBox(height: 50,),
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
                  );
                },
              ),
            ],
          )
      ),
    );
  }
}