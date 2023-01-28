// ignore_for_file: unused_element

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/widgets/image_input.dart';
import 'package:great_places_app/widgets/location_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPlaces extends StatefulWidget {
  static const String routeName = "/add-places";
  const AddPlaces({super.key});

  @override
  State<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  TextEditingController _titleController = TextEditingController();
  File? _pickedImage;
  void _selectImage(File image) {
    _pickedImage = image;
  }

  void _savePlace() {
    print(_titleController.text);
    print(_pickedImage.toString());
    if (_titleController.toString().isEmpty || _pickedImage == null) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(title: Text("Couldn't Add"));
          });
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ImageInput(onSelectImage: _selectImage),
                    const SizedBox(height: 16),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add_circle),
            label: const Text("Submit"),
            style: ButtonStyle(
              fixedSize:
                  MaterialStateProperty.all(const Size(double.infinity, 80)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: MaterialStateProperty.all(0),
            ),
          ),
        ],
      ),
    );
  }
}
