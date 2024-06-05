import 'package:flutter/material.dart';

import 'image_collection_widget.dart';
import 'image_details_view.dart';
import 'image_update.dart';
import 'views/collection_view_model.dart';

class ImageListView extends StatefulWidget {
  const ImageListView({Key? key}) : super(key: key);

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  final viewModel = CollectionViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ sưu tập'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                builder: (context) => const ImageUpdate(),
              ).then((value) {
                if (value != null) {
                  viewModel.addImage(
                    value['image'] ?? '',
                  );
                }
              });
            },
          )
        ],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return GridView.builder(
            padding: const EdgeInsets.all(4.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: viewModel.collections.length,
            itemBuilder: (context, index) {
              final image = viewModel.collections[index];
              return ImageCollectionWidget(
                key: ValueKey(image.id),
                image: image,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageDetailsView(
                        image: image,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
