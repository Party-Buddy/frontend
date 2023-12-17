import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      required this.url,
      required this.height,
      required this.width});

  final String url;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (url.startsWith("http://0.0.0.0")) {
      return Container();
    }
    return ClipRRect(
        borderRadius: kBorderRadius,
        child: url.startsWith("http")
            ? CachedNetworkImage(
                imageUrl: url,
                height: height,
                width: width,
                placeholder: (context, url) => SizedBox(
                  height: height,
                  width: width,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  )),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 30,
                  color: kPrimaryColor,
                ),
              )
            : Image.file(File(url), height: height, width: width,));
  }
}
