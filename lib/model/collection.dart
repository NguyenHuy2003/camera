// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class Collection {
  String id;
  ValueNotifier<String> imageUrl;

  Collection({
    String? id,
    String? imageUrl,
  })  : id = id ?? generateUuid(),
        imageUrl = ValueNotifier(imageUrl ?? '');

  static String generateUuid() {
    return int.parse(
            '${DateTime.now().millisecondsSinceEpoch}${Random().nextInt(100000)}')
        .toRadixString(35)
        .substring(0, 9);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': imageUrl.value,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'] as String,
      imageUrl: map['image'],
    );
  }
}
