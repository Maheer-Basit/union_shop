import 'package:union_shop/models/collections.dart';

class CollectionsService {
  static final _items = <String, Collections>{
    'Winter Favourites': const Collections(
      id: 'c1',
      title: 'Winter Favourites',
      imageUrl: 'assets/images/UOP_Jacket.png',
      productIds: ['p3', 'p4'],
    ),
    'Sale': const Collections(
      id: 'c2',
      title: 'Sale',
      imageUrl: 'assets/images/UOP_Zipped.png',
      productIds: ['p2', 'p5'],
    ),
    'Clothing': const Collections(
      id: 'c3',
      title: 'Clothing',
      imageUrl: 'assets/images/UOP_SH.png',
      productIds: ['p1', 'p2', 'p3', 'p4', 'p5'],
    ),
    'Black Friday': const Collections(
      id: 'c4',
      title: 'Black Friday',
      imageUrl: 'assets/images/UOP_T_Shirt_W.png',
      productIds: ['p1', 'p5'],
    ),
  };

  Future<Collections?> fetchById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final matches = _items.values.where((c) => c.id == id);
    return matches.isNotEmpty ? matches.first : null;
  }

  Future<List<Collections>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return _items.values.toList();
  }

  static List<Collections> getAll() => _items.values.toList();
}
