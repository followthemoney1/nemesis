import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/ui/admin/create_category/create_category_controller.dart';

class CreateCategory extends StatelessWidget {
  Function(GameCategory) pickedCategory;
  final String tag;

  CreateCategory(
      {@required this.tag,
      @required Function(GameCategory) this.pickedCategory})
      : super();

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.card,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: GetBuilder<CreateCategoryController>(
              tag: tag,
              init: CreateCategoryController(firebaseManager: Get.find()),
              builder: (controller) => Column(children: [
                    Flexible(
                      child: TextFormField(
                        controller: controller.teamName,
                      ),
                    ),
                    Row(children: [
                      Expanded(
                        child: DropdownButton<GameCategory>(
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
                            print('${controller} ' +
                                controller.chosenCategory.name);
                            pickedCategory(value);
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.loadCategory();
                          },
                          icon: Icon(Icons.refresh))
                    ]),
                    MaterialButton(
                        child: Text("Add category"),
                        onPressed: () {
                          controller.addCategory();
                        }),
                  ])),
        
      ),
    );
  }
}
