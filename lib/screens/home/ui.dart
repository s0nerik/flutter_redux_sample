import 'package:flutter/material.dart';
import 'package:flutter_app/redux/builder.dart';
import 'package:flutter_app/screens/home/redux.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fab(context),
      body: Row(
        children: <Widget>[
          StateBuilder(
            state: (state) => state.homeState.itemCount,
            builder: (context, dispatch, itemCount) {
              return Text(
                '$itemCount',
                style: Theme.of(context).textTheme.display1,
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _fab(BuildContext context) {
  return DispatcherBuilder(
    builder: (context, dispatch) {
      return FloatingActionButton(
        onPressed: () => dispatch(IncreaseItemsCount()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      );
    },
  );
}
