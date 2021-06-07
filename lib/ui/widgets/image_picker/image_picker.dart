import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/ui/widgets/image_picker/image_picker_controller.dart';

class ImagePickerWidget extends GetWidget<ImagePickerController> {
  final Function(String?) imageUrl;
  ImagePickerWidget({ required this.imageUrl}) {
     ImagePickerController imageController =  Get.put<ImagePickerController>(ImagePickerController(
            firebaseManager: Get.find<FirebaseManager>()),);
  }
  get controller => Get.find<ImagePickerController>();

  var context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return GetBuilder<ImagePickerController>(
        init: controller,
        builder: (controller) {
          if (controller.imageUrl!=null && controller.imageUrl!.isNotEmpty) {
            imageUrl(controller.imageUrl);
          }
          return 
          Row(children:[
          Text('Team Image: ', style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),),  
          Flexible(child:MaterialButton(
            child: controller.imageUrl == null || controller.imageUrl!.isEmpty
                ? Text("Pick Image")
                : Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(controller.imageUrl!),),
            onPressed: () {
              controller.pickImage();
            },
          ),),]);
        });
  }
}
