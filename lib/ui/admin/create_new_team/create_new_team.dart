import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/admin/create_category/create_category.dart';
import 'package:sport_news/ui/widgets/image_picker/image_picker.dart';
import 'package:sport_news/ui/widgets/image_picker/image_picker_controller.dart';
import 'create_team_controller.dart';

class CreateTeam extends StatelessWidget {
  final String tag;
  CreateTeam({
    @required this.tag,
  }) : super();

 ImagePickerController imageController =  Get.put<ImagePickerController>(ImagePickerController(
            firebaseManager: Get.find()),);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide * 0.02),
      child: Material(
        type: MaterialType.card,
        color: Theme.of(context).colorScheme.surface,
        child: GetBuilder<CreateTeamController>(
          tag: tag,
          init: CreateTeamController(Get.find(),tag: tag),
          builder: (controller) => Container(
            child: Padding(
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.shortestSide * 0.02),
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Spacer(),
                        Flexible(
                          child: AutoSizeText(
                            "Choose existing team",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Row(children: [
                          Expanded(
                            child: DropdownButton<LocalTeam>(
                              value: controller.selectedTeam,
                              style: TextStyle(color: Colors.white),
                              items: controller.teams
                                  .map<DropdownMenuItem<LocalTeam>>(
                                      (LocalTeam value) {
                                return DropdownMenuItem<LocalTeam>(
                                  value: value,
                                  child: AutoSizeText(
                                    value.name,
                                    minFontSize: 3,
                                  ),
                                );
                              }).toList(),
                              hint: AutoSizeText(
                                "Please choose a team",
                                minFontSize: 3,
                                maxFontSize: 14,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (LocalTeam value) {
                                controller.selectTeam(value);
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.loadTeams();
                              },
                              icon: Icon(Icons.refresh)),
                        ]),
                        Spacer(),
                        Flexible(
                          child: AutoSizeText(
                            "Or create",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        TextFormField(
                          // initialValue: "Team Name",
                          decoration: InputDecoration(hintText: "Team Name"),
                          onChanged: (value) {
                            controller.createTeam.name = value;
                            controller.update();
                            imageController.imageName = value;
                            print('$tag = ${controller.createTeam.name}');
                          },
                        ),
                        ImagePickerWidget(imageUrl: (url){
                            controller.createTeam.imageUrl = url;
                        },),
                        TextFormField(
                          controller: TextEditingController(),
                          onChanged: (value) {},
                        ),
                        CreateCategory(
                            tag: tag + "_category",
                            pickedCategory: (value) {
                              controller.createTeam.gameCategory = value;
                              controller.update();
                            }),
                      ],
                    ),
                  ),
                  if (controller.createTeam != null &&
                      controller.createTeam.name != null &&
                      controller.createTeam.gameCategory != null)
                    AutoSizeText(
                        'Summary: ${controller.createTeam.name} ${controller.createTeam.gameCategory.name}'),
                  MaterialButton(
                      child: AutoSizeText('Create team'),
                      onPressed: () {
                        controller.addNewTeam();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
