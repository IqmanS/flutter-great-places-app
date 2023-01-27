import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Future<void> _takePicture(ImageSource source) async {
    final imageFile =
        await ImagePicker().pickImage(source: source, maxWidth: 600);
    // _storedImage = imageFile as File?;
  }

  File? _storedImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 150,
          width: 150,
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Image.asset("assets/camera.png"),
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () => _takePicture(ImageSource.camera),
              child: const Text("Click a Picture"),
            ),
            ElevatedButton(
              onPressed: () => _takePicture(ImageSource.gallery),
              child: const Text("Browse Image"),
            ),
          ],
        ),
      ],
    );
  }
}
