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
    'Merchandise': const Collections(
      id: 'c5',
      title: 'Merchandise',
      imageUrl: 'assets/images/UOP_T_Shirt_B.png',
      productIds: ['p6', 'p7', 'p9'],
    ),
    'Signature and Essential Range': const Collections(
      id: 'c6',
      title: 'Signature and Essential Range',
      imageUrl: 'assets/images/UOP_SH.png',
      productIds: ['p1', 'p3', 'p4', 'p5'],
    ),
    'Portsmouth City Collection': const Collections(
      id: 'c7',
      title: 'Portsmouth City Collection',
      imageUrl: 'assets/images/Portsmouth.png',
      productIds: ['p8', 'p10'],
    ),
    'Pride Collection': const Collections(
      id: 'c8',
      title: 'Pride Collection',
      imageUrl: 'assets/images/UOP_T_Shirt.png',
      productIds: ['p11', 'p12'],
    ),
    'Graduation' : const Collections(
      id: 'c9',
      title: 'Graduation',
      imageUrl: 'assets/images/Bow_Tie.png',
      productIds: ['p11', 'p12', 'p9'],
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
