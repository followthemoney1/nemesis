import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class ImagePickerController extends GetxController {
final FirebaseManager firebaseManager;
 String imageName;
final String folder = 'images';
ImagePickerController({@required this.firebaseManager});

  File image;
  final picker = ImagePicker();
  String imageUrl;
  

  pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      // imageUrl =
       await firebaseManager.uploadImage(folder: folder,name: imageName,file: image);
    } else {
      print('No image selected.');
    }

    update();
  }
}
