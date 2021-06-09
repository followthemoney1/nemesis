import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'dart:html' as html;

class ImagePickerController extends GetxController {
  final FirebaseManager firebaseManager =  Get.find<FirebaseManager>();
  final String folder;
  ImagePickerController({required this.folder});

  late html.File image;
  String? imageUrl;

  pickImage() async {
    html.File pickedFile =
        await ImagePickerWeb.getImage(outputType: ImageType.file);

    if (pickedFile != null) {
      image = pickedFile;
      imageUrl = await firebaseManager.uploadImage(folder: folder, file: image);
    } else {
      log('No image selected.');
    }

    update();
  }
}
