import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/pages/counter/bloc/counter_bloc.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  CounterBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CounterBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      cubit: _bloc,
      builder: (BuildContext context, CounterState state) {
        if (state is CounterChangedState) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(state.counter.toString()),
                  ),
                ),
                Row(
                  children: [
                    _buildButton(
                      color: Colors.green,
                      text: "+1",
                      onPressed: () {
                        _bloc.add(IncrementCounter());
                      },
                    ),
                    _buildButton(
                      color: Colors.red,
                      text: "-1",
                      onPressed: () {
                        _bloc.add(DecrementCounter());
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildButton(
                      color: Colors.white24,
                      text: "Value Dialog",
                      onPressed: () {
                        _showCounterValueDialog(_bloc);
                      },
                    ),
                    _buildButton(
                      color: Colors.white24,
                      text: "inc|dec Dialog",
                      onPressed: () {
                        _showCounterButtonsDialog(_bloc, state);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Error"),
          ),
        );
      },
    );
  }

  Widget _buildButton({Color color, String text, Function onPressed}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: MaterialButton(
          color: color,
          child: Text(text),
          onPressed: onPressed,
        ),
      ),
    );
  }

  void _showCounterValueDialog(CounterBloc bloc) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Counter value'),
          content: BlocBuilder<CounterBloc, CounterState>(
            cubit: bloc,
            builder: (BuildContext context, CounterState state) {
              if (state is CounterChangedState) {
                return Text(state.counter.toString());
              }
              return Container();
            },
          ),
        );
      },
    );
  }

  void _showCounterButtonsDialog(CounterBloc bloc, state) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Counter buttons'),
          content: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  color: Colors.green,
                  child: Text("+1"),
                  onPressed: () {
                    _bloc.add(IncrementCounter());
                  },
                ),
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.red,
                  child: Text("-1"),
                  onPressed: () {
                    _bloc.add(DecrementCounter());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
