import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/ui/auth/auth_controller.dart';
import 'package:sport_news/ui/auth/auth_page.dart';
import 'package:sport_news/ui/header/header_controller.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_controller.dart';

import '../../constants.dart';

class Header extends GetWidget<HeaderController> {
  Widget child;
  static final double topHeight = 60;
  Header({Widget child, Key key}) : super(key: key) {
    this.child = child;
  }
  final controller = Get.put(HeaderController(firebaseManager: Get.find()));
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
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: topHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: topHeight,
            width: topHeight,
          ),
          //logo
          Expanded(child: logo()),
          Flexible(
            flex: 4,
            child: userMenu(),
          )
        ],
      ),
    );
  }

  Widget logo() {
    return Padding(
      padding: EdgeInsets.only(left: 26),
      child: Image.asset("assets/images/logotype.png"),
    );
  }

  Widget userMenu() {
    final key = GlobalKey();
    if (controller.loginState == LoggedState.loggin) {
      return Icon(Icons.verified_user);
    } else {
      return IconButton(
        key: key,
        onPressed: () {
          Get.put<AuthController>(AuthController(firebaseManager: Get.find()));

          // Get.toNamed(AuthPage.page);
          Navigator.of(context).push<void>(
            AuthPage.route(
              context,
              key,
              // args: newsElement,
            ),
          );
        },
        icon: Icon(Icons.access_alarm),
      );
    }
  }
}
