import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

part 'redux.g.dart';

// State

abstract class MainState implements Built<MainState, MainStateBuilder> {
  int get navBarSelection;

  MainState._();

  factory MainState([updates(MainStateBuilder b)]) = _$MainState;

  static MainStateBuilder initial() => MainStateBuilder()..navBarSelection = 2;
}

// Actions

class SetNavBarSelection {
  final int selection;

  SetNavBarSelection(this.selection);
}

// Reducers

final mainStateReducer = combineReducers<MainState>([
  TypedReducer(_onSetNavBarSelection),
]);

MainState _onSetNavBarSelection(MainState state, SetNavBarSelection action) =>
    state.rebuild((b) => b..navBarSelection = action.selection);
