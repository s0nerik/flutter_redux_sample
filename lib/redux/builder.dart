import 'package:flutter/widgets.dart';
import 'package:flutter_app/app/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

typedef SubStateSelector<T> = T Function(AppState);
typedef StateWidgetBuilder<T> = Widget Function(BuildContext context, NextDispatcher dispatch, T state);
typedef SubStateProvider<T> = T Function(AppState);

class StateBuilder<T> extends StatelessWidget {
  final SubStateSelector<T> state;
  final StateWidgetBuilder<T> builder;

  const StateBuilder({
    Key key,
    @required this.state,
    @required this.builder,
  })  : assert(state != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SubStateWrapper<T>>(
      converter: (store) => _SubStateWrapper(store, state(store.state)),
      distinct: true,
      builder: (context, stateWrapper) => builder(context, stateWrapper.store.dispatch, stateWrapper.state),
    );
  }
}

@immutable
class _SubStateWrapper<T> {
  final Store<AppState> store;
  final T state;

  _SubStateWrapper(this.store, this.state);

  @override
  bool operator ==(other) => other is _SubStateWrapper<T> && other.state == state;

  @override
  int get hashCode => state.hashCode;
}

typedef DispatcherWidgetBuilder = Widget Function(BuildContext context, NextDispatcher dispatch);

class DispatcherBuilder extends StatelessWidget {
  final DispatcherWidgetBuilder builder;

  const DispatcherBuilder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NextDispatcher>(
      converter: (store) => store.dispatch,
      rebuildOnChange: false,
      builder: builder,
    );
  }
}
