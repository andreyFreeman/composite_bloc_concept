import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_component.dart';

class ComponentBlocProvider<Event, State> extends BlocComponent<State> {
  Bloc<Event, State>? getBloc() => getHost() as Bloc<Event, State>?;
}
