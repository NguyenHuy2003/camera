import 'dart:io';

import 'package:camera/model/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'image_update.dart';
import 'views/collection_view_model.dart';

class ImageDetailsView extends StatefulWidget {
  final Collection image;

  const ImageDetailsView({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageDetailsView> createState() => _ImageDetailsViewState();
}

class _ImageDetailsViewState extends State<ImageDetailsView> {
  final viewModel = CollectionViewModel();

  // Xác nhận xóa hình ảnh
  void _deleteImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận Xóa"),
          content: const Text("Bạn có chắc chắn muốn xóa hình ảnh này không?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                viewModel.removeImage(widget.image.id);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("Xóa"),
            ),
          ],
        );
      },
    );
  }

  // Chỉnh sửa thông tin hình ảnh
  void _editImage(BuildContext context) {
    showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (context) => ImageUpdate(
        initialImage: widget.image.imageUrl.value,
      ),
    ).then((value) {
      if (value != null) {
        viewModel.updateImage(
          widget.image.id,
          value['image'], // Chuyển đường dẫn hình ảnh
        );
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hình ảnh'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editImage(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteImage(context),
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: widget.image.id,
          child: kIsWeb
              ? Image.network(
                  widget.image.imageUrl.value,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                )
              : Image.file(
                  File(widget.image.imageUrl.value),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
