import 'package:flutter/material.dart';
import 'package:flutter_app/redux/builder.dart';
import 'package:flutter_app/screens/list/redux.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      state: (state) => state.listState,
      builder: (context, dispatch, ListState listState) {
        return ListView.builder(
          itemCount: listState.items.length,
          itemBuilder: (context, index) => Text("${listState.items[index]}"),
        );
      },
    );
  }
}
