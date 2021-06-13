import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/header/header.dart';
import 'package:sport_news/ui/match_detail/match_detail_controller.dart';

class MatchDetail extends GetView<MatchDetailController> {
  static final String page = '/MatchDetail';

  MatchDetail({Key? key}) : super(key: key);

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Positioned(
            top: Header.topHeight,
            bottom: 0,
            left: Header.topHeight,
            right: 0,
            child: SafeArea(
              top: true,
              bottom: false,
              child: body(),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Header(onBackPress: (){
              Get.back();
            },),
          ),
        ]),
      ),
    );
  }

  body() {
    return GetBuilder<MatchDetailController>(
      init: controller,
      builder: (_) => CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: 100,
              width: 300,
              child: teamsView(),
            ),
          ]),
        ),
      ]),
    );
  }

  teamsView() {
    return (controller.team1 == null || controller.team2 == null)
        ? CircularProgressIndicator()
        : Flexible(
            flex: 2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        controller.team1!.name.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: NewsThemeData.accentColor),
                        maxLines: 1,
                        minFontSize: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      AutoSizeText(
                        '20%',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white70),
                        maxLines: 1,
                        minFontSize: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(controller.team1!.imageUrl!),
                  ),
                  // Spacer(),
                  AutoSizeText(
                    'VS',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  // Spacer(),
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(controller.team2!.imageUrl!),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        controller.team2!.name.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: NewsThemeData.accentColor),
                        maxLines: 1,
                        minFontSize: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      AutoSizeText(
                        '20%',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white70),
                        maxLines: 1,
                        minFontSize: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ]),
          );
  }
}
