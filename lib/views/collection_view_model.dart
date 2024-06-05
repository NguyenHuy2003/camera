import 'package:camera/model/collection.dart';
import 'package:camera/views/collection_services.dart';
import 'package:flutter/material.dart';

class CollectionViewModel extends ChangeNotifier {
  static final _instance = CollectionViewModel.__internal();
  factory CollectionViewModel() => _instance;
  CollectionViewModel.__internal() {
    services.loodImage().then((values) {
      if (values is List<Collection>) {
        collections.clear();
        collections.addAll(values);
        notifyListeners();
      }
    });
  }
  final List<Collection> collections = [];
  final services = CollectionServices();

  Future<void> addImage(String imageUrl) async {
    var collection = Collection(imageUrl: imageUrl);
    collections.add(collection);
    notifyListeners();

    await services.addImage(collection);
  }

  Future removeImage(String id) async {
    collections.removeWhere((item) => item.id == id);
    notifyListeners();

    services.removeImage(id);
  }

  Future updateImage(String id, String newImage) async {
    try {
      final collection = collections.firstWhere((image) => image.id == id);
      collection.imageUrl.value = newImage;
      notifyListeners();

      await services.updateImage(collection);
    } catch (e) {
      debugPrint("Không tìm thấy mục với ID $id");
    }
  }
}
