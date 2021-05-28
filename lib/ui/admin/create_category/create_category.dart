import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
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
    return Padding(
      padding: EdgeInsets.all(40),
      child: Material(
        type: MaterialType.card,
        color: Theme.of(context).colorScheme.primary,
        child: GetBuilder<CreateCategoryController>(
          tag: tag,
          init: CreateCategoryController(firebaseManager: Get.find()),
          builder: (controller) => Column(children: [
            TextFormField(
              controller: controller.teamName,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Row(children: [
              Expanded(
                child: DropdownButton<GameCategory>(
                  value: controller.chosenCategory,
                  style: Theme.of(context).textTheme.bodyText2,
                  items: controller.categoryes
                      .map<DropdownMenuItem<GameCategory>>(
                          (GameCategory value) {
                    return DropdownMenuItem<GameCategory>(
                      value: value,
                      child: AutoSizeText(
                        value.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  }).toList(),
                  hint: AutoSizeText(
                    "Please choose a category",
                    minFontSize: 12,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  onChanged: (GameCategory value) {
                    controller.selectCategory(value);
                    print('${controller} ' + controller.chosenCategory.name);
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
                child: AutoSizeText(
                  "Add category",
                  minFontSize: 12,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                onPressed: () {
                  controller.addCategory();
                }),
          ]),
        ),
      ),
    );
  }
}
