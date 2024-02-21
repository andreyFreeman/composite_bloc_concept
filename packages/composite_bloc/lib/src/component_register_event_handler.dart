import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_component.dart';
import 'component_bloc_provider.dart';

class ComponentRegisterEventHandler<Event, State> extends BlocComponent<State> {

  ComponentRegisterEventHandler() {
    addDependency<ComponentBlocProvider<Event, State>>();
  }

  void register<E extends Event>(EventHandler<E, State> handler,
      {EventTransformer<E>? transformer}) {
    getComponent<ComponentBlocProvider<Event, State>>()
        ?.getBloc()
        ?.on<E>(handler, transformer: transformer);
  }
}
