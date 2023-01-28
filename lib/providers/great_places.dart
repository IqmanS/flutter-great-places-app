import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/models/place.dart';
import 'package:image_picker/image_picker.dart';

class GreatPlaces with ChangeNotifier {
  final tableName = "user_places";
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        location: null,
        title: title);
    _items.add(newPlace);
    DBHelper.insertToDB(table: tableName, data: {
      "id": DateTime.now().toString(),
      "image": newPlace.image.path,
      "title": newPlace.title,
    });
    notifyListeners();
  }

  Future<void> fetchAndSetItems() async {
    final dataList = await DBHelper.fetchFromDB(tableName);
    _items = dataList
        .map(
          (item) => Place(
            id: item["id"],
            title: item["title"],
            image: File(item["image"]),
          ),
        )
        .toList();

    notifyListeners();
  }
}
