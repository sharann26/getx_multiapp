import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SaveImage extends StatefulWidget {

  SaveImage() : super();

  final String title = "Flutter Save Image";

  @override
  _SaveImageState createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {
  late File _image;
  String _imagePath = '';

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void pickImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void saveImage(path) async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString('imagePath', path);
  }

  void loadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = saveImage.getString('imagePath')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _imagePath != null
              ? Image.asset(_imagePath)
              : CircleAvatar(backgroundImage: FileImage(_image)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                pickImageFromGallery();
              },
              icon: Icon(Icons.photo),
            ),
          ),
          GestureDetector(
            child: Text("Save"),
            onTap: () {
              saveImage(_image.path);
            },
          ),
        ],
      ),
    );
  }
}
