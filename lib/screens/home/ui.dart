import 'package:flutter/material.dart';
import 'package:flutter_app/redux/builder.dart';
import 'package:flutter_app/screens/home/redux.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello redux"),
      ),
      body: _body(context),
      floatingActionButton: _fab(context),
      bottomNavigationBar: _bottomNav(context),
    );
  }
}

Widget _body(BuildContext context) {
  return Row(
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
  );
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

Widget _bottomNav(BuildContext context) {
  return StateBuilder(
    state: (state) => state.homeState.navBarSelection,
    builder: (context, dispatch, selection) {
      return BottomNavigationBar(
        currentIndex: selection,
        onTap: (selection) => dispatch(SetNavBarSelection(selection)),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(width: 24, height: 24),
            title: Text("Unused"),
          ),
          BottomNavigationBarItem(
            icon: SizedBox(width: 24, height: 24),
            title: Text("List"),
          ),
          BottomNavigationBarItem(
            icon: SizedBox(width: 24, height: 24),
            title: Text("Home"),
          ),
        ],
      );
    },
  );
}
