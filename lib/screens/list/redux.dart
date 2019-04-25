import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

part 'redux.g.dart';

// State

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

// Actions

class LoadAction {}

class LoadSuccessAction {}

class LoadErrorAction {}

class ApplyFilterAction {
  final String query;

  ApplyFilterAction(this.query);
}

class FilterAppliedAction {
  final List<String> items;

  FilterAppliedAction(this.items);
}

// Reducers

final listReducer = combineReducers<ListState>([
  TypedReducer(_onLoad),
  TypedReducer(_onLoadSuccess),
  TypedReducer(_onLoadError),
//  TypedReducer<ListState, ApplyFilterAction>(_onLoad),
//  TypedReducer<SearchState, SearchErrorAction>(_onError),
//  TypedReducer<SearchState, SearchResultAction>(_onResult),
]);

ListState _onLoad(ListState state, LoadAction action) => state.rebuild((s) => s..isLoading = true);

ListState _onLoadSuccess(ListState state, LoadErrorAction action) => state.rebuild((b) => b
  ..isLoading = false
  ..hasLoadError = false);

ListState _onLoadError(ListState state, LoadErrorAction action) => state.rebuild((b) => b
  ..isLoading = false
  ..hasLoadError = true);
