import 'package:demo_bloc_arch/controller/counter_bloc/counter_bloc.dart';
import 'package:demo_bloc_arch/controller/counter_bloc/counter_states.dart';
import 'package:demo_bloc_arch/views/counter/counter_bloc_builder.dart';
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
        title: const Text("Counter Bloc Consumer Demo"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

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
                  FloatingActionButton(onPressed: (){
                    context.read<CounterBloc>().add(CounterIncrementEvent());
                  }, child: const Icon(Icons.add),),
                  const SizedBox(width: 20,),
                  FloatingActionButton(onPressed: (){
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
// BlocBuilder<CounterBloc, CounterState>(
// builder: (context, state) {
// return Column(
// children: [
// Center(
// child: Text("${state.counter.toString()}", style: TextStyle(fontSize: 15),),
// ),
// SizedBox(height: 50,),
// Row(
// children: [
// FloatingActionButton(onPressed: (){
// context.read<CounterBloc>().add(CounterIncrementEvent());
// }, child: Icon(Icons.add),),
// SizedBox(width: 20,),
// FloatingActionButton(onPressed: (){
// context.read<CounterBloc>().add(CounterDecrementEvent());
// }, child: Icon(Icons.remove),)
// ],
// ),
// ],
// );
// },
// ),


// BlocListener<CounterBloc, CounterState>(
// listener: (context, state) {
// if(state.counter >= 5){
// showDialog(context: context,
// builder: (BuildContext context) {
// return AlertDialog(title: Text("Hello ${state.counter}"),);
// },
// );
// }
// },
// child: Column(
// children: [
// Text("Bloc Listener"),
// Row(
// children: [
// FloatingActionButton(onPressed: (){
// context.read<CounterBloc>().add(CounterIncrementEvent());
// }, child: Icon(Icons.add),),
// SizedBox(width: 20,),
// FloatingActionButton(onPressed: (){
// context.read<CounterBloc>().add(CounterDecrementEvent());
// }, child: Icon(Icons.remove),)
// ],
// ),
// ],
// ),
// )

//BlocConsumer<CounterBloc, CounterState>(builder: (context, state){
//               return Center(
//                 child: Text("${state.counter.toString()}", style: TextStyle(fontSize: 15),),
//               );
//             }, listener: (context, state){
//               if(state.counter >= 5) {
//                 showDialog(context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(title: Text("Hello ${state.counter}"),);
//                   },
//                 );
//               }
//             },
//             ),