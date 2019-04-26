import 'package:flutter_app/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements Bloc {
  final _itemCount = BehaviorSubject<int>.seeded(0);

  ValueObservable<int> get itemCount => _itemCount.stream;

  void increaseItemsCount() {
    _itemCount.value += 1;
  }

  @override
  void dispose() {
    _itemCount.close();
  }
}
