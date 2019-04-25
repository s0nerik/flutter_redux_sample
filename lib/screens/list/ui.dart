import 'package:flutter/material.dart';
import 'package:flutter_app/redux/builder.dart';
import 'package:flutter_app/screens/list/redux.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      state: (state) => state.listState,
      onInit: (store) => store.dispatch(LoadAction()),
      builder: (context, dispatch, ListState state) {
        return ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (context, index) => Text("${state.items[index]}"),
        );
      },
    );
  }
}
