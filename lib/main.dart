import 'package:flutter/material.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initial().build(),
  );
  runApp(MyApp(store: store));
}
