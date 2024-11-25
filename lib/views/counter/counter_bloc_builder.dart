import 'package:demo_bloc_arch/controller/counter_bloc/counter_bloc.dart';
import 'package:demo_bloc_arch/controller/counter_bloc/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/counter_bloc/counter_events.dart';

class CounterBlocBuilder extends StatelessWidget {
  const CounterBlocBuilder({super.key});

  final int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc Builder Demo"),
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
                        child: Text(state.counter.toString(), style: const TextStyle(fontSize: 15),),
                      ),
                      const SizedBox(height: 50,),
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
                  );
                },
              ),
            ],
          )
      ),
    );
  }
}