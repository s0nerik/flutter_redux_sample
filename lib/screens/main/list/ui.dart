import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/bloc/value_observable_builder.dart';
import 'package:flutter_app/screens/main/list/bloc.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listBloc = BlocProvider.of<ListBloc>(context);
    return ValueObservableBuilder<List<String>>(
      valueObservable: listBloc.items,
      builder: (BuildContext context, List<String> items, Widget child) {
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => Text("${items[index]}"),
        );
      },
    );
  }
}
