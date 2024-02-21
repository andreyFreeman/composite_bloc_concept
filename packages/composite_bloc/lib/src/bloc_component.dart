import 'package:composite/composite.dart';

abstract class BlocComponent<State> extends ComponentBehaviour {
  Future<void> onState(State state) async {}
}