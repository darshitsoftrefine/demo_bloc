import 'package:demo_bloc_arch/controller/counter_bloc/counter_bloc.dart';
import 'package:demo_bloc_arch/controller/counter_bloc/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/counter_bloc/counter_events.dart';

class CounterBlocListener extends StatelessWidget {
  const CounterBlocListener({super.key});

  final int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc Listener Demo"),
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
                    const Text("Bloc Listener"),
                    Row(
                      children: [
                        FloatingActionButton(
                          heroTag: null,
                          onPressed: (){
                          context.read<CounterBloc>().add(CounterIncrementEvent());
                        }, child: const Icon(Icons.add),),
                        const SizedBox(width: 20,),
                        FloatingActionButton(
                          heroTag: null,
                          onPressed: (){
                          context.read<CounterBloc>().add(CounterDecrementEvent());
                        }, child: const Icon(Icons.remove),)
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