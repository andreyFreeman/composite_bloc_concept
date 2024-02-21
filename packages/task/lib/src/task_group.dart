import 'task_base.dart';

class ParallelGroupTask<Input> extends TaskBase<Input, void> {
  final List<TaskBase<Input, dynamic>> _tasks;

  ParallelGroupTask(this._tasks);

  @override
  Future<void> execute(Input input) async =>
      Future.wait(_tasks.map((task) => task.execute(input)).toList());
}

class SerialGroupTask<Input> extends TaskBase<Input, void> {
  final List<TaskBase<Input, dynamic>> _tasks;

  SerialGroupTask(this._tasks);

  @override
  Future<void> execute(Input input) async {
    for (final task in _tasks) {
      await task.execute(input);
    }
  }
}
