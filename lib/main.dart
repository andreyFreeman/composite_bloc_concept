import 'package:composite_bloc/composite_bloc.dart';
import 'package:composite_bloc_sample_app/counter_event.dart';
import 'package:composite_bloc_sample_app/counter_state.dart';
import 'package:flutter/material.dart';

import 'component_state_logger.dart';
import 'counter_component_increment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late CompositeBloc<CounterEvent, CounterState> _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CompositeBloc(state: CounterState(), components: [
      ComponentBlocProvider<CounterEvent, CounterState>(),
      ComponentRegisterEventHandler<CounterEvent, CounterState>(),
      ComponentIncrement(),
      ComponentStateLogger()
    ]);
    _bloc.stream.listen((state) {
      setState(() {
        _counter = state.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.add(CounterEvent.increment()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}