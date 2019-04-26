import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/bloc/value_observable_builder.dart';
import 'package:flutter_app/screens/main/home/bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeBloc = Bloc.of<HomeBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: homeBloc.increaseItemsCount,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: Row(
        children: <Widget>[
          ValueObservableBuilder<int>(
            valueObservable: homeBloc.itemCount,
            builder: (context, itemCount, child) {
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
