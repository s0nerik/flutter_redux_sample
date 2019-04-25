import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

part 'redux.g.dart';

// State

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
  int get navBarSelection;

  int get itemCount;

  HomeState._();

  factory HomeState([updates(HomeStateBuilder b)]) = _$HomeState;

  static HomeStateBuilder initial() => HomeStateBuilder()
    ..itemCount = 0
    ..navBarSelection = 2;
}

// Actions

class IncreaseItemsCount {}

class SetNavBarSelection {
  final int selection;

  SetNavBarSelection(this.selection);
}

// Reducers

final homeStateReducer = combineReducers<HomeState>([
  TypedReducer(_onNavBarSelection),
  TypedReducer(_onIncreaseItemsCount),
]);

HomeState _onNavBarSelection(HomeState state, SetNavBarSelection action) =>
    state.rebuild((b) => b..navBarSelection = action.selection);

HomeState _onIncreaseItemsCount(HomeState state, IncreaseItemsCount action) => state.rebuild((b) => b..itemCount += 1);
