import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter_app/app/redux.dart';
import 'package:flutter_app/screens/home/redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

part 'redux.g.dart';

// region State

abstract class ListState implements Built<ListState, ListStateBuilder> {
  BuiltList<String> get items;

  bool get isLoading;

  bool get hasLoadError;

  bool get isFiltering;

  bool get isEmpty => items.isEmpty;

  ListState._();

  factory ListState([updates(ListStateBuilder b)]) = _$ListState;

  static ListStateBuilder initial() => ListStateBuilder()
    ..items.clear()
    ..isLoading = false
    ..hasLoadError = false
    ..isFiltering = false;
}

// endregion State

// region Actions

class LoadAction {}

class LoadSuccessAction {
  final List<String> items;

  LoadSuccessAction(this.items);
}

class LoadErrorAction {}

class ApplyFilterAction {
  final String query;

  ApplyFilterAction(this.query);
}

class FilterAppliedAction {
  final List<String> items;

  FilterAppliedAction(this.items);
}

// endregion Actions

// region Reducers

final listReducer = combineReducers<ListState>([
  TypedReducer(_onLoad),
  TypedReducer(_onLoadSuccess),
  TypedReducer(_onLoadError),
]);

ListState _onLoad(ListState state, LoadAction action) => state.rebuild((s) => s..isLoading = true);

ListState _onLoadSuccess(ListState state, LoadSuccessAction action) => state.rebuild((b) => b
  ..items = ListBuilder(action.items)
  ..isLoading = false
  ..hasLoadError = false);

ListState _onLoadError(ListState state, LoadErrorAction action) => state.rebuild((b) => b
  ..isLoading = false
  ..hasLoadError = true);

// endregion Reducers

// region Epics

final listEpic = combineEpics<AppState>([
  TypedEpic(_loadItemsEpic),
  TypedEpic(_increaseItemsCountEpic),
]);

Stream<dynamic> _loadItemsEpic(Stream<LoadAction> actions, EpicStore<AppState> store) {
  return Observable(actions).switchMap(
      (action) => Observable.timer(LoadSuccessAction(List.generate(1000, (i) => "Item $i")), Duration(seconds: 2)));
}

Stream<dynamic> _increaseItemsCountEpic(Stream<IncreaseItemsCount> a, EpicStore<AppState> store) {
  final changes = Observable(store.onChange);
  final items = changes.map((s) => s.listState.items).where((l) => l.isNotEmpty).distinct();
  final count = changes.map((s) => s.homeState.itemCount).distinct();
  return Observable.combineLatest2(items, count, (BuiltList<String> i, int c) => LoadSuccessAction(i.take(c).toList()));
}

// endregion Epics
