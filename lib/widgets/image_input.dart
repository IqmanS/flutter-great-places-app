// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  Function onSelectImage;
  ImageInput({
    Key? key,
    required this.onSelectImage,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Future<void> _takePicture(ImageSource source) async {
    final imageXFile =
        await ImagePicker().pickImage(source: source, maxWidth: 600);
    if (imageXFile != null) {
      final imageFile = File(imageXFile.path);
      setState(() {
        _storedImage = imageFile;
      });
      final appDirectory = await syspath.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await imageFile.copy("${appDirectory.path}/$fileName");
      widget.onSelectImage(savedImage);
    }
  }

  File? _storedImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).primaryColorLight, width: 3)),
          height: 150,
          width: 150,
          alignment: Alignment.center,
          child: _storedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _storedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              : Image.asset("assets/camera.png"),
        ),
        const SizedBox(width: 40),
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
