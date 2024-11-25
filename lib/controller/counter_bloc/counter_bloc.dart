import 'package:demo_bloc_arch/controller/counter_bloc/counter_events.dart';
import 'package:demo_bloc_arch/controller/counter_bloc/counter_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvents, CounterState> {

  CounterBloc() : super(CounterInitialState()) {
    on<CounterIncrementEvent>((event, emit) {
      emit(CounterIncrementState(state.counter + 1));
    });

    on<CounterDecrementEvent>((event, emit) {
      emit(CounterDecrementState(state.counter - 1));
    });

  }
}