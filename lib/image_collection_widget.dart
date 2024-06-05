import 'dart:io';

import 'package:camera/model/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageCollectionWidget extends StatelessWidget {
  final Collection image;
  final VoidCallback? onTap;

  const ImageCollectionWidget({Key? key, required this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: image.imageUrl.value.isNotEmpty
              ? DecorationImage(
                  image: kIsWeb
                      ? NetworkImage(image.imageUrl.value)
                      : FileImage(File(image.imageUrl.value)) as ImageProvider,
                  fit: BoxFit.cover,
                )
              : null,
          color: Colors.grey[200], // Placeholder color
        ),
        child: image.imageUrl.value.isEmpty
            ? const Center(
                child: Icon(
                  Icons.add_photo_alternate,
                  size: 40,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}
