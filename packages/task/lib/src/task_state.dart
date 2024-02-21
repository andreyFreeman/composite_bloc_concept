abstract class TaskState<Input, Output> {
  const TaskState();
  const factory TaskState.ready() = TaskStateReady;
  const factory TaskState.executing(Input input) = TaskStateExecuting;
  const factory TaskState.finished(Output output) = TaskStateFinished;
  const factory TaskState.failed(Error error) = TaskStateFailed;
}

class TaskStateReady<Input, Output> extends TaskState<Input, Output> {
  const TaskStateReady() : super();
}

class TaskStateExecuting<Input, Output> extends TaskState<Input, Output> {
  final Input input;
  const TaskStateExecuting(this.input);
}

class TaskStateFinished<Input, Output> extends TaskState<Input, Output> {
  final Output output;
  const TaskStateFinished(this.output);
}

class TaskStateFailed<Input, Output> extends TaskState<Input, Output> {
  final Error error;
  const TaskStateFailed(this.error);
}