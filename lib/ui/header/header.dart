import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/ui/auth/login/login_controller.dart';
import 'package:sport_news/ui/auth/login/login_page.dart';
import 'package:sport_news/ui/auth/registration/registration_controller.dart';
import 'package:sport_news/ui/auth/registration/registration_page.dart';
import 'package:sport_news/ui/header/header_controller.dart';
import 'package:sport_news/ui/widgets/animated_icons/back_icon/back_icon.dart';
import 'package:sport_news/ui/widgets/animated_icons/back_icon/back_icon_controller.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_controller.dart';

import '../../constants.dart';
import 'package:sport_news/pr_extension.dart';

class Header extends GetWidget<HeaderController> {
  Widget? child;
  static final double topHeight = 60;
  bool onBackEnabled = false;
  Function()? onBackPress;
  Header({Widget? child, Key? key, Function()? this.onBackPress})
      : super(key: key) {
    this.child = child;
    if (onBackPress != null) {
      onBackEnabled = true;
    }
  }
  final controller = Get.find<HeaderController>();

  final BackIconController backIconController =
      Get.put<BackIconController>(BackIconController());
  var context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: GetBuilder(
        init: controller,
        builder: (_) => Material(
          color: Theme.of(context).backgroundColor,
          type: MaterialType.card,
          elevation: 6,
          child: header(),
        
      ),),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.only(right: 26),
      child: Container(
        height: topHeight,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            !onBackEnabled
                ? Container(
                    height: topHeight,
                    width: topHeight,
                  )
                : Container(width: topHeight*2,child:Padding(
                    padding: EdgeInsets.only(left: topHeight),
                    child: Container(child: backIcon())
                        .addOnTap(onTap: onBackPress!),
                  ),),
            
            //logo
           logo().padOnly(left: 26),
            Spacer(),
            userMenu(),
          ],
        ),
      ),
    );
  }

  backIcon() {
    return MouseRegion(
      onEnter: (v) {
        backIconController.toggle(true);
      },
      onExit: (v) {
        backIconController.toggle(false);
      },
      child: BackIcon(
        controller: backIconController,
      ),
    );
  }

  Widget logo() {
    return  Hero(tag: 'size_logo',child:Image.asset("assets/images/logotype.png"),);
  }

  Widget userMenu() {
    final key = GlobalKey();
    if (controller.loginState == LoggedState.loggin) {
      return Icon(Icons.verified_user);
    } else {
      return Row(
        children: [
          MaterialButton(
            key: key,
            focusColor: Color(0xff404751),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
              child: AutoSizeText(
                'Registration',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              Get.put<RegistrationController>(RegistrationController(
                  firebaseManager: Get.find(), userManager: Get.find()));

              // Get.toNamed(AuthPage.page);
              Navigator.of(context).push<void>(
                RegistrationPage.route(
                  context,
                  key,
                  args: {},
                ),
              );
            },
          ),
          MaterialButton(
            focusColor: Color(0xff404751),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
              child: AutoSizeText(
                'Sign In',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              Get.put<LoginController>(
                  LoginController(firebaseManager: Get.find()));

              // Get.toNamed(AuthPage.page);
              Navigator.of(context).push<void>(
                LoginPage.route(
                  context,
                  key,
                  args: {},
                ),
              );
            },
          ),
        ],
      );
    }
  }
}
