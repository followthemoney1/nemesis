import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/ui/admin/create_category/create_category_controller.dart';

class CreateCategory extends StatelessWidget {
  Function(GameCategory) pickedCategory;
  final String tag;
  CreateCategory({@required this.tag,Function(GameCategory) pickedCategory}):super() {
    this.pickedCategory = pickedCategory;
    print(tag);
    Get.put(CreateCategoryController(Get.find()), tag: tag);
  }

  get controller => Get.find<CreateCategoryController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: 
      GetBuilder<CreateCategoryController>(
          init: controller,
          builder: (_) {
            return Container(
              child: Material(
                type: MaterialType.card,
                child: Column(children: [
                  TextFormField(
                    controller: controller.teamName,
                  ),
                  DropdownButton<GameCategory>(
                    value: controller.chosenCategory,
                    style: TextStyle(color: Colors.white),
                    items: controller.categoryes
                        .map<DropdownMenuItem<GameCategory>>(
                            (GameCategory value) {
                      return DropdownMenuItem<GameCategory>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose a category",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (GameCategory value) {
                      controller.selectCategory(value);
                      pickedCategory(value);
                    },
                  ),
                  MaterialButton(
                      child: Text("Add category"),
                      onPressed: () {
                        controller.addCategory();
                      })
                ]),
              ),
            );
          }),
    );
  }
}
