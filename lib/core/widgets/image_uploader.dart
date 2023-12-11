import 'dart:io';
import 'dart:typed_data';
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
import 'package:path_provider/path_provider.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader(
      {super.key,
      required this.onUpdate,
      this.imageSize = 200,
      this.isOptional = true});

  final void Function(File) onUpdate;
  final double imageSize;
  final bool isOptional;

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? image;
  Uint8List? imageBytes;
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
                    await Future.microtask(() => showWidget(context,
                        content: const CircularProgressIndicator(
                          color: kPrimaryColor,
                        )));
                    final bitmap = await controller.croppedBitmap();
                    final byteData =
                        await bitmap.toByteData(format: ImageByteFormat.png);
                    final dirName = await getApplicationDocumentsDirectory();

                    File file = File(join(dirName.path,
                        '${DateTime.now().microsecondsSinceEpoch}.png'));
                    await file.writeAsBytes(byteData!.buffer.asUint8List(
                        byteData.offsetInBytes, byteData.lengthInBytes));

                    imageBytes = file.readAsBytesSync();
                    await Future.microtask(() => Navigator.of(context).pop());
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
    return InkwellBorderWrapper(
      onPressed: () async => getImage(context),
      child: imageBytes != null
          ? ClipRRect(
              borderRadius: kBorderRadius,
              child: Image.memory(
                imageBytes!,
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
                    Visibility(
                        visible: widget.isOptional,
                        child: Text("(Опционально)",
                            style: defaultTextStyle(
                                fontSize: 17, color: darken(kFontColor))))
                  ]),
            ),
    );
  }
}
