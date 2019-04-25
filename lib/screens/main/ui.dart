import 'package:flutter/material.dart';
import 'package:flutter_app/redux/builder.dart';
import 'package:flutter_app/screens/home/ui.dart';
import 'package:flutter_app/screens/list/ui.dart';
import 'package:flutter_app/screens/main/redux.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello redux"),
      ),
      body: _body(context),
      bottomNavigationBar: _bottomNav(context),
    );
  }
}

Widget _body(BuildContext context) {
  return StateBuilder(
    state: (state) => state.mainState.navBarSelection,
    builder: (context, dispatch, int navBarSelection) {
      switch (navBarSelection) {
        case 1:
          return ListScreen();
        case 2:
          return HomeScreen();
        default:
          return Container();
      }
    },
  );
}

Widget _bottomNav(BuildContext context) {
  return StateBuilder(
    state: (state) => state.mainState.navBarSelection,
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
