abstract class CounterState{
  int counter = 0;

  CounterState({required this.counter});
}

class CounterInitialState extends CounterState {

  CounterInitialState() : super(counter: 0);
}

class CounterIncrementState extends CounterState {

  CounterIncrementState(int incrementCounter) : super(counter: incrementCounter);
}

class CounterDecrementState extends CounterState {

  CounterDecrementState(int decrementCounter) : super(counter: decrementCounter);
}