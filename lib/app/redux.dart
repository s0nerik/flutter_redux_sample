import 'package:built_value/built_value.dart';
import 'package:flutter_app/screens/home/redux.dart';
import 'package:flutter_app/screens/list/redux.dart';
import 'package:flutter_app/screens/main/redux.dart';
import 'package:redux_epics/redux_epics.dart';

part 'redux.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  MainState get mainState;

  ListState get listState;

  HomeState get homeState;

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  static AppStateBuilder initial() => AppStateBuilder()
    ..mainState = MainState.initial()
    ..listState = ListState.initial()
    ..homeState = HomeState.initial();
}

AppState appStateReducer(AppState state, action) {
  return state.rebuild((b) => b
    ..mainState.replace(mainStateReducer(state.mainState, action))
    ..listState.replace(listReducer(state.listState, action))
    ..homeState.replace(homeStateReducer(state.homeState, action)));
}

final appEpic = combineEpics<AppState>([
  listEpic,
]);
