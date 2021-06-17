import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:measured_size/measured_size.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/header/header.dart';
import 'package:sport_news/ui/match_detail/match_detail_controller.dart';
import 'package:sport_news/ui/widgets/gradient_button.dart';
import 'package:sport_news/ui/widgets/my_text_field.dart';
import 'package:get/get.dart';
import 'package:sport_news/ui/widgets/pimp_left.dart';
import 'package:sport_news/ui/widgets/twitch/twitch_player.dart';

class MatchDetail extends GetView<MatchDetailController> {
  static final String page = '/matchDetail';

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
            left: 0,
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
            child: Header(
              onBackPress: () {
                Get.back();
              },
            ),
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
              height: 1200,
              width: double.infinity,
              child: Row(children: [
                Expanded(
                  child: leftPanel(),
                ),
                Expanded(
                  child: rightPanel(),
                ),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  rightPanel() {
    return Column(
      children: [
        CardHolder(
            secionName: 'game streams',
            child: Container(
              height: 700,
              child: TwitchPlayer(
                streamName: 'weplaydota',
              ),
            )),
      ],
    );
  }

  leftPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardHolder(
          secionName: 'match detail',
          child: Column(children: [
            matchLogo(),
            Container(height: 40),
            teams(),
            placeABet(),
          ]),
        ),
        CardHolder(
          secionName: 'teams statistic',
          child: Column(children: []),
        ),
      ],
    );
  }

  matchLogo() {
    if (controller.league == null) {
      return Container();
    }
    return Container(
      height: 100,
      width: double.infinity,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.network(
          controller.league!.imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  teams() {
    if (controller.team1 == null || controller.team2 == null)
      return Container();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //team 1
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 30),
              AutoSizeText(
                controller.team1!.name.toString(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: NewsThemeData.accentColor, fontSize: 20),
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
              Container(height: 10),
              TextButton(
                onPressed: () {},
                child: AutoSizeText(
                  'Show Team Info'.toUpperCase(),
                  minFontSize: 6,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white24, fontSize: 8),
                ),
              ),
            ],
          ),
          Container(
            width: 80,
            height: 80,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(controller.team1!.imageUrl!),
          ),

          Column(children: [
            AutoSizeText(
              'VS',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            AutoSizeText(
              'BO' + controller.match!.bo.toString(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: NewsThemeData.buttonMainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 8),
            ),
          ]),

          Container(
            width: 80,
            height: 80,
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
              Container(height: 30),
              AutoSizeText(
                controller.team2!.name.toString(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: NewsThemeData.accentColor, fontSize: 20),
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
              Container(height: 10),
              TextButton(
                onPressed: () {},
                child: AutoSizeText(
                  'Show Team Info'.toUpperCase(),
                  minFontSize: 6,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white24, fontSize: 8),
                ),
              ),
            ],
          ),
        ]);
  }

  GlobalKey<FormState> formKey = GlobalKey();
  placeABet() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            width: 160,
            child: MyTextFormField(
              hint: '1000',
              prefixIcon: Icons.attach_money,
              validator: (v) {
                if (double.tryParse(v.toString())! < 0.01) {
                  return 'The value must be greater than 0.01';
                }

                if (v.contains(".") &&
                    v.substring(v.indexOf(".") + 1).length > 2) {
                  return 'You must not use more than 2 decimal places';
                }

                return !v.toString().isNum
                    ? 'Write a correct number please'
                    : null;
              },
              onChange: (v) {
                v = double.tryParse(v.toString())!.toStringAsPrecision(2);
                formKey.currentState!.validate();
              },
            ),
          ).paddingAll(30),
          GradientButton(
            innerText: 'Place bet',
            padding: 20,
          ),
        ],
      ),
    );
  }
}

class CardHolder extends StatelessWidget {
  final Widget child;
  final String secionName;

  CardHolder(
      {required Widget this.child, required String this.secionName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Card(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 6),
            child: Row(
              children: [
                PimpLeft(
                  height: 20,
                  width: 3,
                ),
                Container(
                  width: 8,
                ),
                AutoSizeText(
                  secionName.toUpperCase(),
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                )
              ],
            ),
          ),
          child,
          Container(height: 6),
        ],
      )),
    );
  }
}
