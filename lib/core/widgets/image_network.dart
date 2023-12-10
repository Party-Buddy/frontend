import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork(
      {super.key,
      required this.url,
      required this.height,
      required this.width});

  final String url;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: kBorderRadius,
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(color: kPrimaryColor,),
            ),
            Image.network(url,
                width: width,
                height: height,
                // loadingBuilder: (BuildContext context, Widget child,
                //     ImageChunkEvent? loadingProgress) {
                //   if (loadingProgress == null) return child;
                //   return Container(
                //     width: width,
                //     height: height,
                //     alignment: Alignment.center,
                //     child: CircularProgressIndicator(
                //       color: kPrimaryColor,
                //       value: loadingProgress.expectedTotalBytes != null
                //           ? loadingProgress.cumulativeBytesLoaded /
                //               loadingProgress.expectedTotalBytes!
                //           : null,
                //     ),
                //   );
                // },
                errorBuilder: (context, _, error) => const Icon(
                      Icons.error,
                      size: 90,
                      color: kPrimaryColor,
                    ))
          ],
        ));
  }
}
