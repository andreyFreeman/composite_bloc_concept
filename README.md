# Composite Bloc Concept

Sample app illustrates concept of composite bloc. Components attached to a BLoC and implement business logic in a clean and abstract way.
Take on solving "too large BLoC" problem by breaking down particular tasks to components.

## Features

- components may be added/removed to a CompositeBloc instance (extends Bloc).
- components may access other components attached to the same host
- components may require other compeennts to be added
- components may access host (bloc)
- components may subscribe to event using 'on<Event>' and update bloc state using 'emit'
- task library provides capability to incapsulate units of job to be executed and abolity to chain those units together in various ways

## Sample App

Sample app implements increment/decrement behaviour without having to subclass the BLoC but adding a few (reusable) components to it instead.
