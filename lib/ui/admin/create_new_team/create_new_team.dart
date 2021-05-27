import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/ui/admin/create_category/create_category.dart';
import 'create_team_controller.dart';

class CreateTeam extends StatelessWidget {
  final String tag;
  CreateTeam({
    @required this.tag,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.isPhone ? 40 : 120),
      child: GetBuilder<CreateTeamController>(
        tag: tag,
        init: CreateTeamController(Get.find()),
        builder: (controller) => Container(
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "Team Name",
                      onChanged: (value) {
                        controller.team.name = value;
                        controller.update();
                        print('$tag = ${controller.team.name}');
                      },
                    ),
                    TextFormField(
                      controller: TextEditingController(),
                      onChanged: (value) {},
                    ),
                    Spacer(),
                    Flexible(
                      child: CreateCategory(
                          tag: tag + "_category",
                          pickedCategory: (value) {
                            controller.team.gameCategory = value;
                            controller.update();
                          }),
                    ),
                  ],
                ),
              ),
              if (controller.team != null &&
                  controller.team.name != null &&
                  controller.team.gameCategory != null)
                Text(
                    'Summary: ${controller.team.name} ${controller.team.gameCategory.name}'),

              // MaterialButton(,onPressed: (){
              //   controller.publish();
              // })
            ],
          ),
        ),
      ),
    );
  }
}
