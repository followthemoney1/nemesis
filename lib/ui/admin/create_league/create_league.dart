import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/ui/widgets/image_picker/image_picker.dart';

import 'create_league_controller.dart';

class CreateLeague extends StatelessWidget {
  final Function(League?) onSelect;
  CreateLeague({required this.onSelect});

  final controller = Get.put<CreateLeagueController>(CreateLeagueController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateLeagueController>(
        init: controller,
        builder: (_) => Column(
              children: [
                Flexible(
                  child: Column(children: [
                    Spacer(),
                    Flexible(
                      child: AutoSizeText(
                        "Choose existing League",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Row(children: [
                      Expanded(
                        child: DropdownButton<League>(
                          value: controller.selectedLeague,
                          style: TextStyle(color: Colors.white),
                          items: controller.leagues
                              .map<DropdownMenuItem<League>>(
                                  (League value) {
                            return DropdownMenuItem<League>(
                              value: value,
                              child: AutoSizeText(
                                value.name!,
                                minFontSize: 3,
                              ),
                            );
                          }).toList(),
                          hint: AutoSizeText(
                            "Please choose a league",
                            minFontSize: 3,
                            maxFontSize: 14,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (League? value) {
                            controller.selectedLeague = value;
                            onSelect(value);
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                             controller.loadLeague();
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
                      decoration: InputDecoration(hintText: "League Name"),
                      onChanged: (value) {
                        controller.createLeague.name = value;
                      },
                    ),
                    ImagePickerWidget(
                      folder: 'leagueImages',
                      imageUrl: (url) {
                        controller.createLeague.imageUrl = url;
                      },
                    ),
                    MaterialButton(child: AutoSizeText('Create League'),onPressed: (){
                      controller.addNewLeague();
                    }),
                  ]),
                )
              ],
            ));
  }
}
