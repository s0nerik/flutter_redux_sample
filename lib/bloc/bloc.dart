import 'package:flutter/widgets.dart';

Type _typeOf<T>() => T;

abstract class Bloc {
  void dispose();
}

// Generic BLoC provider
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends Bloc>(BuildContext context) {
    final type = _typeOf<_InheritedBlocProvider<T>>();
    _InheritedBlocProvider<T> provider = context.ancestorInheritedElementForWidgetOfExactType(type).widget;
    return provider.bloc;
  }
}

class _BlocProviderState<T extends Bloc> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedBlocProvider<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _InheritedBlocProvider<T extends Bloc> extends InheritedWidget {
  final T bloc;

  const _InheritedBlocProvider({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
