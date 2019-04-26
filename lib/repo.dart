Future<List<String>> loadItems() => Future.delayed(Duration(seconds: 2), () => List.generate(1000, (i) => "Item $i"));
