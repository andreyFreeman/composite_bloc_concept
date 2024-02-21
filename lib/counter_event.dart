abstract class CounterEvent {
  factory CounterEvent.increment() = IncrementEvent;
  factory CounterEvent.decrement() = DecrementEvent;

  const CounterEvent();
}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}