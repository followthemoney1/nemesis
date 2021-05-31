import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/ui/admin/create_new_team/create_team_controller.dart';

import 'admin_panel_controller.dart';
import 'create_new_team/create_new_team.dart';

class AdminPanel extends GetView<AdminPanelController> {
  static final String page = "/admin";
  final String firstTeamTAG = "firstT";
  final String secondTeamTAG = "secondT";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Flexible(
          child: Row(
            children: [
              Flexible(
                  child: CreateTeam(
                tag: firstTeamTAG,
              )),
              Flexible(
                  child: CreateTeam(
                tag: secondTeamTAG,
              ))
            ],
          ),
        ),
        Obx(
          () => TextButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018, 3, 5),
                  maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                print('confirm $date');
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
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Match URL"),
          onChanged: (value) {
            //mark:
          },
        ),
        MaterialButton(
            child: Text("Create a match"),
            onPressed: () {
              controller.createMatch(Get.find<CreateTeamController>(tag: firstTeamTAG),Get.find<CreateTeamController>(tag: secondTeamTAG));
            })
      ]),
    );
  }
}
