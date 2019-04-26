import 'package:flutter/widgets.dart';

Type _typeOf<T>() => T;

abstract class Bloc {
  void dispose();

  static T of<T extends Bloc>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider = context.ancestorInheritedElementForWidgetOfExactType(type).widget;
    return provider.bloc;
  }
}

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final WidgetBuilder builder;

  const BlocProvider(this.bloc, {Key key, @required this.builder})
      : assert(bloc != null),
        assert(builder != null),
        super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends Bloc> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.builder(context),
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
  final WidgetBuilder builder;

  const BlocProvider2(this.bloc1, this.bloc2, {Key key, @required this.builder})
      : assert(bloc1 != null),
        assert(bloc2 != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc1,
      builder: (context) => BlocProvider(
            bloc2,
            builder: builder,
          ),
    );
  }
}

class BlocProvider3<T1 extends Bloc, T2 extends Bloc, T3 extends Bloc> extends StatelessWidget {
  final T1 bloc1;
  final T2 bloc2;
  final T3 bloc3;
  final WidgetBuilder builder;

  const BlocProvider3(this.bloc1, this.bloc2, this.bloc3, {Key key, @required this.builder})
      : assert(bloc1 != null),
        assert(bloc2 != null),
        assert(bloc3 != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc1,
      builder: (context) => BlocProvider(
            bloc2,
            builder: (context) => BlocProvider(
                  bloc3,
                  builder: builder,
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
  final WidgetBuilder builder;

  const BlocProvider4(this.bloc1, this.bloc2, this.bloc3, this.bloc4, {Key key, @required this.builder})
      : assert(bloc1 != null),
        assert(bloc2 != null),
        assert(bloc3 != null),
        assert(bloc4 != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc1,
      builder: (context) => BlocProvider(
            bloc2,
            builder: (context) => BlocProvider(
                  bloc3,
                  builder: (context) => BlocProvider(
                        bloc4,
                        builder: builder,
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
  final WidgetBuilder builder;

  const BlocProvider5(this.bloc1, this.bloc2, this.bloc3, this.bloc4, this.bloc5, {Key key, @required this.builder})
      : assert(bloc1 != null),
        assert(bloc2 != null),
        assert(bloc3 != null),
        assert(bloc4 != null),
        assert(bloc5 != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc1,
      builder: (context) => BlocProvider(
            bloc2,
            builder: (context) => BlocProvider(
                  bloc3,
                  builder: (context) => BlocProvider(
                        bloc4,
                        builder: (context) => BlocProvider(
                              bloc5,
                              builder: builder,
                            ),
                      ),
                ),
          ),
    );
  }
}
