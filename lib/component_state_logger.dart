import 'package:composite_bloc/composite_bloc.dart';

class ComponentStateLogger<State> extends BlocComponent<State> {
  @override
  Future<void> onState(State state) async {
    print('$runtimeType.setState($state)');
  }
}