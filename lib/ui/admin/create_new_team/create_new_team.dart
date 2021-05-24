import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/ui/admin/create_category/create_category.dart';
import 'create_team_controller.dart';

class CreateTeam extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.isPhone ? 40 : 120),
        child: GetBuilder(
          init: CreateTeamController(Get.find()),
          builder:(controller){
          return Container(
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    TextFormField(
                      controller: TextEditingController(),
                     
                      onChanged: (value) {
                        controller.team.name = value;
                        controller.update();
                        print(controller.team.name);
                      },
                    ),
                    TextFormField(
                      controller: TextEditingController(),
                      
                      onChanged: (value) {},
                    ),
                    Flexible(child:CreateCategory(
                        tag: "team1",
                        pickedCategory: (value) {
                          controller.team.gameCategory = value;
                          controller.update();
                        }),),
                  ],
                ),
              ),
              if(controller.team.name !=null&&controller.team.gameCategory !=null)
              Text('Summary: ${controller.team.name} ${controller.team.gameCategory.name}'),
            
            // MaterialButton(,onPressed: (){
            //   controller.publish();
            // })
            ],
        ),);
      }),
      ),
    );
  }
}
