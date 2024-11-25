import 'package:demo_bloc_arch/controller/counter_bloc/counter_bloc.dart';
import 'package:demo_bloc_arch/controller/counter_bloc/counter_states.dart';
import 'package:demo_bloc_arch/views/counter/counter_bloc_builder.dart';
import 'package:demo_bloc_arch/views/counter/counter_bloc_consumer.dart';
import 'package:demo_bloc_arch/views/counter/counter_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/counter_bloc/counter_events.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("What do you want to see the widget with ?"),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CounterBlocBuilder()),
              );
            }, child: const Text("Bloc Builder")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CounterBlocListener()),
              );
            }, child: const Text("Bloc Listener")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CounterBlocConsumer()),
              );
            }, child: const Text("Bloc Consumer")),
            const SizedBox(height: 20,),
            const Text("Bloc Selector"),

            BlocSelector<CounterBloc, CounterState, bool>(selector: (state) => state.counter >= 3 ? true : false,
                builder: (context, state) {
              return Column(
                children: [
                  Center(child: Container(
                    height: 200,
                    width: 200,
                    color: state ? Colors.green : Colors.orange,)),
                ],
              );
            }),
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