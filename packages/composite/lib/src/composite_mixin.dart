import 'component_behaviour.dart';

abstract class HostedComponent {
  final List<Type> requiredComponents = [];
  HostedComponent();

  void attach(ComponentHost<HostedComponent> host);
  void detach();
  ComponentHost<HostedComponent>? getHost();
  ComponentType? getComponent<ComponentType extends HostedComponent>();
  List<ComponentType> getComponents<ComponentType extends HostedComponent>();

  void addDependency<T extends HostedComponent>() => requiredComponents.add(T);
}

abstract class ComponentHost<Component extends HostedComponent> {
  void addComponent(Component component);
  void removeComponent(Component component);
  List<ComponentType> getComponents<ComponentType extends Component>();
  ComponentType? getComponent<ComponentType extends Component>();
}

mixin CompositeMixin<Component extends HostedComponent> implements ComponentHost<Component> {
  final List<Component> _components = [];

  @override
  void addComponent(Component component) {
    for (final type in component.requiredComponents) {
      var found = false;
      for (final registerdComponent in _components) {
        found = registerdComponent.runtimeType == type;
        if (found) {
          break;
        }
      }
      if (!found) {
        throw Exception('Required dependency: $type not found in components');
      }
    }
    _components.add(component);
    component.attach(this);
  }

  void addComponents(List<Component> components) {
    components.forEach(addComponent);
  }

  @override
  void removeComponent(Component component) {
    if (_components.remove(component)) {
      component.detach();
    }
  }

  @override
  List<ComponentType> getComponents<ComponentType extends Component>() =>
      _components.whereType<ComponentType>().toList();

  @override
  ComponentType? getComponent<ComponentType extends Component>() {
    for (final component in _components) {
      if (component is ComponentType) {
        return component;
      }
    }
    return null;
  }

  Future<void> _executeOnComponentsSerial(Future<void> Function(Component) process) async {
    for (final component in _components) {
      await process(component);
    }
  }

  Future<void> executeOnComponents(Future<void> Function(Component) process) async {
    await _executeOnComponentsSerial(process);
  }
}
