import 'package:demo_bloc_arch/controller/counter_bloc/counter_bloc.dart';
import 'package:demo_bloc_arch/controller/counter_bloc/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/counter_bloc/counter_events.dart';

class CounterBlocConsumer extends StatelessWidget {
  const CounterBlocConsumer({super.key});

  final int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc Consumer Demo"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              BlocConsumer<CounterBloc, CounterState>(builder: (context, state){
              return Center(
                child: Text(state.counter.toString(), style: const TextStyle(fontSize: 15),),
              );
            }, listener: (context, state){
              if(state.counter >= 5) {
                showDialog(context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(title: Text("Hello ${state.counter}"),);
                  },
                );
              }
            },
            ),
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
          )
      ),
    );
  }
}