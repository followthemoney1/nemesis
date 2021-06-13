import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rive/rive.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/header/header.dart';
import 'package:sport_news/ui/widgets/animated_icons/menu/menu_icon.dart';
import 'package:sport_news/ui/widgets/animated_icons/menu/menu_icon_controller.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_controller.dart';

import 'package:sport_news/ui/widgets/pimp_left.dart';

class FluidNavBar extends StatelessWidget {
  final Function(int) onChange;
  final int selectedIndex;
  final Color backgroundColor = Color(0xFF363c45);

  FluidNavBar(
      {required this.selectedIndex, required Function(int) this.onChange});

  final controller = Get.find<FluidController>();
  final menuIconController = Get.put<MenuIconController>(MenuIconController());

  late var context;
  @override
  Widget build(BuildContext context) {
    this.context = context;

    return GetBuilder<FluidController>(
      init: controller,
      builder: (_) => AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve:
            controller.widthChange ? Curves.easeInToLinear : Curves.easeOutBack,
        child: Container(
          width: controller.nominalWidth,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 8.0,
                offset: Offset(3.0, -1),
              ),
            ],
          ),
          child: Column(
            children: [
              Flexible(
                child: icon(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    menuIcon(
                        assetName: 'assets/icons/home_icon.svg',
                        sectionName: 'Home',
                        index: 0,
                        procentIconSize: 0.35),
                    menuIcon(
                        assetName: 'assets/icons/dota-2.svg',
                        sectionName: 'Dota 2',
                        index: 1,
                        procentIconSize: 0.40),
                    menuIcon(
                        assetName: 'assets/icons/csgo.svg',
                        sectionName: 'Counter-Strike: GO',
                        index: 2,
                        procentIconSize: 0.54),
                    menuIcon(
                        assetName: 'assets/icons/league-of-legends.svg',
                        sectionName: 'League of Legends',
                        index: 3,
                        procentIconSize: 0.50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget menuIcon(
      {required String assetName,
      required String sectionName,
      required int index,
      required double procentIconSize}) {
    bool isSelected = selectedIndex == index;
    return Container(
      width: controller.nominalWidth,
      height: Header.topHeight,
      child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            onChange(index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PimpLeft(
                height: Header.topHeight - 10,
                width: isSelected ? 3 : 0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 6, right: 6),
                child: AnimatedContainer(
                  
                  width: Header.topHeight - 20,
                  height: Header.topHeight - 20,
                  
                  decoration: BoxDecoration(
                    color: isSelected
                        ? NewsThemeData.accentColor
                        : NewsThemeData.iconBackgroundDisabled,
                    borderRadius: BorderRadius.circular(isSelected ? 10 : 50),
                  ),
                  duration: Duration(seconds: 1),
                  curve: Curves.easeOutBack,
                  child: FractionallySizedBox(
                    heightFactor: procentIconSize,
                    child: SvgPicture.asset(
                      assetName,
                      semanticsLabel: sectionName,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              controller.widthChange
                  ? Expanded(
                      child: AutoSizeText(
                        sectionName,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w100),
                      ),
                    )
                  : Container(),
            ],
          )),
    );
  }

  Widget icon() {
    return Container(
      width: controller.nominalWidth,
      height: Header.topHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color:
                !controller.widthChange ? Colors.black38 : Colors.transparent,
            blurRadius: 12.0,
            offset: Offset(4, -1),
          )
        ],
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          controller.click();
          menuIconController.toggle(controller.widthChange);
        },
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 400),
          alignment:
              controller.widthChange ? Alignment.centerLeft : Alignment.center,
          child: Padding(
              padding: EdgeInsets.only(left: controller.widthChange ? 16 : 0),
              child: Container(
                height: 30,
                width: 30,
                child: MenuIcon(
                  controller: menuIconController,
                ),
              )),
        ),
      ),
    );
  }
}
