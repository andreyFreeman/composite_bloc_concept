import 'package:composite_bloc/composite_bloc.dart';
import 'package:composite_bloc_sample_app/counter_event.dart';
import 'package:composite_bloc_sample_app/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: BlocProvider(
        create: (context) => createCounterBloc(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }

  CompositeBloc<CounterEvent, CounterState> createCounterBloc() {
    return CompositeBloc<CounterEvent, CounterState>(
        state: CounterState(), 
        components: [
          ComponentBlocProvider<CounterEvent, CounterState>(),
          ComponentRegisterEventHandler<CounterEvent, CounterState>(),
          ComponentIncrement<IncrementEvent>(incrementor: 1),
          ComponentIncrement<DecrementEvent>(incrementor: -1),
          ComponentStateLogger()
        ]
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: BlocBuilder<CompositeBloc<CounterEvent, CounterState>, CounterState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Counter Value:',
                ),
                Text(
                  '${state.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () =>
                context.read<CompositeBloc<CounterEvent, CounterState>>().add(CounterEvent.increment()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () =>
                context.read<CompositeBloc<CounterEvent, CounterState>>().add(CounterEvent.decrement()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}