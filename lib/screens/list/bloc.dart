import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/repo.dart';
import 'package:rxdart/rxdart.dart';

class ListBloc implements Bloc {
  final ValueObservable<int> _itemCount;

  final _items = BehaviorSubject<List<String>>.seeded([]);

  ValueObservable<List<String>> get items =>
      Observable.combineLatest2(_itemCount, _items, (int c, List<String> items) => items.take(c).toList())
          .shareValueSeeded([]);

  ListBloc(this._itemCount) {
    _loadItems();
  }

  void _loadItems() async {
    final items = await loadItems();
    _items.value = items;
  }

  @override
  void dispose() {
    _items.close();
  }
}
