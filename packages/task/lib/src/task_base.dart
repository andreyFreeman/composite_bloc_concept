import 'dart:async';

import 'task_state.dart';

class TaskError extends Error {
  Object? object;
  TaskError(this.object);
}

abstract class TaskInterface<Input, Output> {
  Future<Output> execute(Input input);
}

abstract class TaskBase<Input, Output> implements TaskInterface<Input, Output> {
  Stream<TaskState<Input, Output>> executeStreamed(Input input) async* {
    yield TaskState.executing(input);
    try {
      yield TaskState.finished(await execute(input));
    } catch (e) {
      yield TaskState.failed(TaskError(e));
    }
  }
}
