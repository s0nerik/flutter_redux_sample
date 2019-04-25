import 'package:built_value/built_value.dart';
import 'package:flutter_app/screens/home/redux.dart';
import 'package:flutter_app/screens/list/redux.dart';

part 'redux.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  ListState get listState;

  HomeState get homeState;

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  static AppStateBuilder initial() => AppStateBuilder()
    ..listState = ListState.initial()
    ..homeState = HomeState.initial();
}

AppState appStateReducer(AppState state, action) {
  return state.rebuild((b) => b
    ..listState.replace(listReducer(state.listState, action))
    ..homeState.replace(homeStateReducer(state.homeState, action)));
}
