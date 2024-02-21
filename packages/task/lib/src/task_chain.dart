import 'task.dart';
import 'task_base.dart';

extension TaskChain<Input, Output> on TaskInterface<Input, Output> {
  Task<Input, NextOutput> then<NextOutput>(TaskInterface<Output, NextOutput> task) =>
      Task<Input, NextOutput>.async((input) async => task.execute(await execute(input)));

  Task<Input, NextOutput> thenExecute<NextOutput>(NextOutput Function(Output) execute) =>
      then(Task.sync(execute));
}
