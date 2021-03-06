import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/ui/admin/create_new_team/create_team_controller.dart';

import 'admin_panel_controller.dart';
import 'create_category/create_category.dart';
import 'create_league/create_league.dart';
import 'create_new_team/create_new_team.dart';

class AdminPanel extends GetView<AdminPanelController> {
  static final String page = "/admin";
  final String firstTeamTAG = "firstT";
  final String secondTeamTAG = "secondT";

 final firstTeamController =  Get.put(CreateTeamController(),
        tag: "firstT");

  final secondTeamController =  Get.put(CreateTeamController(),
        tag: "secondT");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: 300,
              child: CreateLeague(
                onSelect: (league) {
                  controller.selectedLeagueId = league!.snapshotID;
                  log('selected league id = ${controller.selectedLeagueId}');
                },
              ),
            ).paddingAll(80),

         CreateCategory(
                tag: "team_category",
                pickedCategory: (value) {
                  controller.selectedGameCategory = value;
                  firstTeamController.gameCategory = value;
                  secondTeamController.gameCategory = value;
                }),
            Container(
              height: 600,
              width: double.infinity,
              child: Row(
                children: [
                  Flexible(
                      child: CreateTeam(
                    tag: firstTeamTAG,
                     controller: firstTeamController,
                  )),
                  Flexible(
                      child: CreateTeam(
                    tag: secondTeamTAG,
                    controller: secondTeamController,
                   
                  ))
                ],
              ),
            ).paddingAll(80),

            Obx(
              () => TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                    log('change $date');
                  }, onConfirm: (date) {
                    log('confirm $date');
                    // controller.setStartTime(date);
                    controller.startTime.value = date;
                  }, currentTime: DateTime.now(), locale: LocaleType.ru);
                },
                child: Text(
                  'Picked date   :::   Date - ${controller.startTime.value.month}:${controller.startTime.value.day} Time - ${controller.startTime.value.hour}:${controller.startTime.value.minute}',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "How many BO we got"),
              onChanged: (value) {
                //mark:
              },
            ).paddingOnly(left: 80, right: 80),
            TextFormField(
              decoration: InputDecoration(hintText: "Match URL"),
              onChanged: (value) {
                //mark:
              },
            ).paddingOnly(left: 80, right: 80),
            MaterialButton(
                child: Text("Create a match"),
                onPressed: () {
                  controller.createMatch(
                      Get.find<CreateTeamController>(tag: firstTeamTAG),
                      Get.find<CreateTeamController>(tag: secondTeamTAG));
                }),
            // ]),
          ]),
        ),
      ]),
    );
  }
}
