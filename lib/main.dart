import 'package:flutter/material.dart';
import 'package:flutter_app/app/app.dart';
import 'package:flutter_app/app/redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

void main() {
  runApp(MyApp(store: store()));
}

Store<AppState> store() => Store<AppState>(
      appStateReducer,
      initialState: AppState.initial().build(),
      middleware: [
        _loggingMiddleware,
        EpicMiddleware<AppState>(appEpic),
      ],
    );

_loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: ${action.runtimeType}');
  next(action);
}
