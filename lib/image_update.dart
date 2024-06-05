// Widget cho màn hình cập nhật điện thoại
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpdate extends StatefulWidget {
  final String? initialImage;

  const ImageUpdate({
    Key? key,
    this.initialImage,
  }) : super(key: key);

  @override
  State<ImageUpdate> createState() => _ImageUpdateState();
}

class _ImageUpdateState extends State<ImageUpdate> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.initialImage;
  }

  // Chọn và thiết lập hình ảnh cho điện thoại
  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }

  // Chọn và thiết lập hình ảnh cho điện thoại
  void _pickAndSetImage() async {
    final imagePath = await _pickImage();
    if (imagePath != null) {
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialImage != null ? 'Thay thế ảnh' : 'Thêm ảnh'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop({
                'image': _imagePath, // Chuyển đường dẫn hình ảnh cho người gọi
              });
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickAndSetImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _imagePath != null
                      ? kIsWeb
                          ? Image.network(
                              _imagePath!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(_imagePath!),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                      : const Icon(
                          Icons.add_photo_alternate,
                          size: 60,
                          color: Colors.grey,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
