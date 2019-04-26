import 'package:flutter_app/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc implements Bloc {
  final _navBarSelection = BehaviorSubject.seeded(2);
  ValueObservable<int> get navBarSelection => _navBarSelection.stream;

  void setNavBarSelection(int value) => _navBarSelection.value = value;

  @override
  void dispose() {
    _navBarSelection.close();
  }
}
