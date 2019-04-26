import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/bloc/value_observable_builder.dart';
import 'package:flutter_app/screens/main/bloc.dart';
import 'package:flutter_app/screens/main/home/bloc.dart';
import 'package:flutter_app/screens/main/home/ui.dart';
import 'package:flutter_app/screens/main/list/bloc.dart';
import 'package:flutter_app/screens/main/list/ui.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainBloc = MainBloc();
    final homeBloc = HomeBloc();
    final listBloc = ListBloc(homeBloc.itemCount);

    return BlocProvider3(
      mainBloc,
      homeBloc,
      listBloc,
      builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text("Hello bloc"),
            ),
            body: _body(context),
            bottomNavigationBar: _bottomNav(context),
          ),
    );
  }
}

Widget _body(BuildContext context) {
  final mainBloc = Bloc.of<MainBloc>(context);

  return ValueObservableBuilder<int>(
    valueObservable: mainBloc.navBarSelection,
    builder: (context, navBarSelection, child) {
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
  final mainBloc = Bloc.of<MainBloc>(context);

  return ValueObservableBuilder<int>(
    valueObservable: mainBloc.navBarSelection,
    builder: (BuildContext context, int navBarSelection, Widget child) {
      return BottomNavigationBar(
        currentIndex: navBarSelection,
        onTap: mainBloc.setNavBarSelection,
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
