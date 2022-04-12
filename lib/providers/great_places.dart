import 'package:flutter/foundation.dart';
import 'dart:io';
import '../models/place.dart';
import '../helper/db_helper.dart';
import '../helper/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place finaById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String title, File pickImage, PlaceLocation pickedLocation) async {
    final address = await LocaationHelper.getPlaceAddress(
        pickedLocation.latitude as double, pickedLocation.longitude as double);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newplace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: pickImage);
    _items.add(newplace);

    DBHelper.insert("user_places", {
      'id': newplace.id as String,
      'title': newplace.title as String,
      'image': newplace.image!.path,
      'loc_lat': newplace.location?.latitude as double,
      'loc_lng': newplace.location?.longitude as double,
      'address': newplace.location?.address as String
    });
    notifyListeners();
  }

  Future fechAndSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            location: PlaceLocation(
                latitude: e['loc_lat'],
                longitude: e['loc_lng'],
                address: e['address']),
            image: File(e['image'])))
        .toList();
    notifyListeners();
  }
}
