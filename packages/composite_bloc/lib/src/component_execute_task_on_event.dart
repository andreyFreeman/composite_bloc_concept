import 'package:composite_bloc/composite_bloc.dart';
import 'package:task/task.dart';

class ComponentExecuteTasksOnEvent<BlockEvent, State, Event extends BlockEvent>
    extends BlocComponent<State> {
  final List<TaskBase<Event, State?>> _tasks;
  ComponentExecuteTasksOnEvent._(this._tasks) {
    addDependency<ComponentRegisterEventHandler<BlockEvent, State>>();
  }

  factory ComponentExecuteTasksOnEvent.single(TaskBase<Event, State?> task) =>
      ComponentExecuteTasksOnEvent._([task]);
  factory ComponentExecuteTasksOnEvent.multiple(List<TaskBase<Event, State?>> tasks) =>
      ComponentExecuteTasksOnEvent._(tasks);

  @override
  Future<void> onInitialize() async {
    getComponent<ComponentRegisterEventHandler<BlockEvent, State>>()!
        .register<Event>((event, emit) async {
      for (final task in _tasks) {
        final state = await task.execute(event);
        if (state != null) {
          emit(state);
        }
      }
    });
  }
}
