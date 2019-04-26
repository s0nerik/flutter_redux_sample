import 'package:flutter/widgets.dart';

abstract class Bloc {
  void dispose();
}

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider(this.bloc, {Key key, @required this.child}) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends Bloc>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider = context.ancestorInheritedElementForWidgetOfExactType(type).widget;
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T extends Bloc> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T extends Bloc> extends InheritedWidget {
  final T bloc;

  const _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class BlocProvider2<T1 extends Bloc, T2 extends Bloc> extends StatelessWidget {
  final T1 bloc1;
  final T2 bloc2;
  final Widget child;

  const BlocProvider2(this.bloc1, this.bloc2, {Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc1,
      child: BlocProvider(
        bloc2,
        child: child,
      ),
    );
  }
}

class BlocProvider3<T1 extends Bloc, T2 extends Bloc, T3 extends Bloc> extends StatelessWidget {
  final T1 bloc1;
  final T2 bloc2;
  final T3 bloc3;
  final Widget child;

  const BlocProvider3(this.bloc1, this.bloc2, this.bloc3, {Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc1,
      child: BlocProvider(
        bloc2,
        child: BlocProvider(
          bloc3,
          child: child,
        ),
      ),
    );
  }
}

class BlocProvider4<T1 extends Bloc, T2 extends Bloc, T3 extends Bloc, T4 extends Bloc> extends StatelessWidget {
  final T1 bloc1;
  final T2 bloc2;
  final T3 bloc3;
  final T4 bloc4;
  final Widget child;

  const BlocProvider4(this.bloc1, this.bloc2, this.bloc3, this.bloc4, {Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc1,
      child: BlocProvider(
        bloc2,
        child: BlocProvider(
          bloc3,
          child: BlocProvider(
            bloc4,
            child: child,
          ),
        ),
      ),
    );
  }
}

class BlocProvider5<T1 extends Bloc, T2 extends Bloc, T3 extends Bloc, T4 extends Bloc, T5 extends Bloc>
    extends StatelessWidget {
  final T1 bloc1;
  final T2 bloc2;
  final T3 bloc3;
  final T4 bloc4;
  final T5 bloc5;
  final Widget child;

  const BlocProvider5(this.bloc1, this.bloc2, this.bloc3, this.bloc4, this.bloc5, {Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc1,
      child: BlocProvider(
        bloc2,
        child: BlocProvider(
          bloc3,
          child: BlocProvider(
            bloc4,
            child: BlocProvider(
              bloc5,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
