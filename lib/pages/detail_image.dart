// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class DetailImage extends StatefulWidget {
  String imageurl;
  DetailImage({
    super.key,
    required this.imageurl,
  });

  @override
  State<DetailImage> createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PhotoView(
        imageProvider: NetworkImage(widget.imageurl),
        loadingBuilder: (context, event) => const Center(
            child: LinearProgressIndicator(),
          ),
        )
      )
    );
  }
}
