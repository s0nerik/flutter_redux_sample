import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

part 'redux.g.dart';

// State

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
  int get itemCount;

  HomeState._();

  factory HomeState([updates(HomeStateBuilder b)]) = _$HomeState;

  static HomeStateBuilder initial() => HomeStateBuilder()..itemCount = 0;
}

// Actions

class IncreaseItemsCount {}

// Reducers

final homeStateReducer = combineReducers<HomeState>([
  TypedReducer(_onIncreaseItemsCount),
]);

HomeState _onIncreaseItemsCount(HomeState state, IncreaseItemsCount action) => state.rebuild((b) => b..itemCount += 1);
