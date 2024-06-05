import 'package:localstore/localstore.dart';

import '../model/collection.dart';

class CollectionServices {
  Future loodImage() async {
    var db = Localstore.getInstance(useSupportDir: true);
    var mapCollection = await db.collection('collections').get();
    if (mapCollection != null && mapCollection.isNotEmpty) {
      var collections = List<Collection>.from(
          mapCollection.entries.map((e) => Collection.fromMap(e.value)));
      return collections;
    }
    return null;
  }

  Future addImage(Collection image) async {
    var db = Localstore.getInstance(useSupportDir: true);
    db.collection('collections').doc(image.id).set(image.toMap());
  }

  Future removeImage(String id) async {
    var db = Localstore.getInstance(useSupportDir: true);
    db.collection('collections').doc(id).delete();
  }

  Future updateImage(Collection image) async {
    var db = Localstore.getInstance(useSupportDir: true);
    await db
        .collection('collections')
        .doc(image.id)
        .set(image.toMap(), SetOptions(merge: true));
  }
}
