import 'dart:io';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';
import "package:path/path.dart";

class ImageUploader extends StatefulWidget {
  const ImageUploader(
      {super.key, required this.onUpdate, this.imageSize = 200});

  final void Function(File) onUpdate;
  final double imageSize;

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? image;
  final controller = CropController(aspectRatio: 1);

  Future getImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);

    await Future.microtask(() {
      showWidget(context,
          content: Column(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: CropImage(
                  image: Image.file(imageTemp),
                  controller: controller,
                ),
              ),
              const SizedBox(
                height: kPadding,
              ),
              CustomButton(
                  text: "Выбрать",
                  onPressed: () async {
                    final bitmap = await controller.croppedBitmap();
                    final byteData =
                        await bitmap.toByteData(format: ImageByteFormat.png);
                    final dirName = dirname(image.path);

                    File file = File(join(dirName, "cropped_image.png"));
                    await file.writeAsBytes(byteData!.buffer.asUint8List(
                        byteData.offsetInBytes, byteData.lengthInBytes));

                    setState(() {
                      this.image = file;
                    });
                    widget.onUpdate(file);
                    await Future.microtask(() => Navigator.of(context).pop());
                  })
            ],
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: InkwellBorderWrapper(
        onPressed: () async => getImage(context),
        child: image != null
            ? ClipRRect(
                borderRadius: kBorderRadius,
                child: Image.memory(
                  image!.readAsBytesSync(),
                  fit: BoxFit.fitHeight,
                  width: widget.imageSize,
                  height: widget.imageSize,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    borderRadius: kBorderRadius, color: lighten(kAppBarColor)),
                width: widget.imageSize,
                height: widget.imageSize,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                    "Загрузить изображение",
                    style: defaultTextStyle(fontSize: 17),
                  ),
                  Text("(Опционально)", style: defaultTextStyle(fontSize: 17, color: darken(kFontColor)))
                ]),
              ),
      ),
    );
  }
}
