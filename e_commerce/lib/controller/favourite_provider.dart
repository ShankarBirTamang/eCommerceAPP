import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');

  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];
  List<dynamic> _fav = [];

  List<dynamic> get ids => _ids;
  List<dynamic> get fav => _fav;
  List<dynamic> get favorites => _favorites;

  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

  set fav(List<dynamic> newFav) {
    _fav = newFav;
    notifyListeners();
  }

  set favorites(List<dynamic> newFav) {
    _favorites = newFav;
    notifyListeners();
  }

  getFavourite() {
    final favData = _favBox.keys.map(
      (key) {
        final item = _favBox.get(key);
        return {'key': key, 'id': item['id']};
      },
    ).toList();
    _favorites = favData.toList();
    _ids = _favorites.map((item) => item['id']).toList();
    // debugPrint("IDS : $ids");
  }

  getAllData() {
    final favData = _favBox.keys.map(
      (key) {
        final item = _favBox.get(key);
        return {
          'key': key,
          'id': item['id'],
          'name': item['name'],
          'category': item['category'],
          'price': item['price'],
          'imageUrl': item['imageUrl'],
        };
      },
    ).toList();
    _fav = favData.reversed.toList();
  }

  // this functions adds items on _favBox and
  // each time create function is called ,
  // we are going to getFavourite after created .
  Future<void> createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    debugPrint("$addFav has been added to ${_favBox.values}");
    getFavourite();
  }

 Future<void> deleteFav(int key) async {
    await _favBox.delete(key);
  }

}
