import 'package:composite_bloc/composite_bloc.dart';
import 'package:composite_bloc_sample_app/counter_event.dart';
import 'package:composite_bloc_sample_app/counter_state.dart';

class ComponentIncrement<Event extends CounterEvent> extends BlocComponent<CounterState> {
  final int incrementor;
  ComponentIncrement({this.incrementor = 1}) {
    addDependency<ComponentRegisterEventHandler<CounterEvent, CounterState>>();
  }

  @override
  Future<void> onInitialize() async {
    getComponent<ComponentRegisterEventHandler<CounterEvent, CounterState>>()!
    .register<Event>((event, emit) => 
    emit(CounterState(value: getComponent<ComponentBlocProvider<CounterEvent, CounterState>>()!.getBloc()!.state.value + incrementor)));
  }        
}