import 'package:flutter/material.dart';
import 'package:flutter_app/app/app.dart';
import 'package:flutter_app/app/redux.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(MyApp(store: store()));
}

Store<AppState> store() => Store<AppState>(
      appStateReducer,
      initialState: AppState.initial().build(),
    );
