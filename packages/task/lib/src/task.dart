import 'task_base.dart';

class Task<Input, Output> extends TaskBase<Input, Output> {
  final Future<Output> Function(Input) executor;

  Task._(this.executor);

  factory Task.sync(Output Function(Input) executor) => Task._((input) async => executor(input));
  factory Task.async(Future<Output> Function(Input) executor) => Task._(executor);

  @override
  Future<Output> execute(Input input) => executor(input);
}
