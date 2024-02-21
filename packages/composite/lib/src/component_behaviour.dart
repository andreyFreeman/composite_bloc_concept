import '../composite.dart';

abstract class ComponentBehaviour extends HostedComponent {
  WeakReference<ComponentHost<HostedComponent>>? _hostReference;

  @override
  void attach(ComponentHost<HostedComponent> host) => _hostReference = WeakReference(host);

  @override
  void detach() => _hostReference = null;

  @override
  ComponentHost<HostedComponent>? getHost() => _hostReference?.target;

  @override
  ComponentType? getComponent<ComponentType extends HostedComponent>() =>
      getHost()?.getComponent<ComponentType>();

  @override
  List<ComponentType> getComponents<ComponentType extends HostedComponent>() =>
      getHost()?.getComponents<ComponentType>() ?? [];

  Future<void> onInitialize() async {}
  Future<void> onReset() async {}
  void dispose() {}
}

extension CompositeOfComponentBehaviours on CompositeMixin<ComponentBehaviour> {
  Future<void> initializeComponents() async =>
      executeOnComponents((component) => component.onInitialize());
  Future<void> resetComponents() async => executeOnComponents((component) => component.onReset());
}
