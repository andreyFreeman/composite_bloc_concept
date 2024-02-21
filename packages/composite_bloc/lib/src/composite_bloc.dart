import 'package:composite/composite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_component.dart';

class CompositeBloc<Event, State> extends Bloc<Event, State>
    with CompositeMixin<BlocComponent<State>> {
  CompositeBloc({required State state, required List<BlocComponent<State>> components})
      : super(state) {
    addComponents(components);
    components.forEach((component) { 
      component.onInitialize();
    });
    stream.listen(_onStateChange);
  }

  void _onStateChange(State state) {
    executeOnComponents((component) => component.onState(state));
  }
}
