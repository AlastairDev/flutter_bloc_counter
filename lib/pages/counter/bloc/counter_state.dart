part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterChangedState extends CounterState {
  final int counter;
  CounterChangedState(this.counter);
}
