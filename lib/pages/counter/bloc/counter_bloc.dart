import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterChangedState(0));

  int counter = 0;

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is IncrementCounter) {
      await Future.delayed(Duration(milliseconds: 500));
      counter += 1;
      yield CounterChangedState(counter);
    } else if (event is DecrementCounter) {
      await Future.delayed(Duration(milliseconds: 500));
      counter -= 1;
      yield CounterChangedState(counter);
    }
  }
}
