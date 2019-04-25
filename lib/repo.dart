import 'package:rxdart/rxdart.dart';

Stream<List<String>> loadItems() => Observable.timer(List.generate(1000, (i) => "Item $i"), Duration(seconds: 2));
