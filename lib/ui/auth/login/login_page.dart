import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:get/route_manager.dart';
import 'package:sport_news/ui/auth/registration/registration_controller.dart';
import 'package:sport_news/ui/widgets/expand_item_transition.dart';
import 'package:sport_news/ui/widgets/my_text_field.dart';
import 'package:sport_news/ui/widgets/pimp_left.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  static final String page = '/login_page';

  final arguments;
  final widgetKey;

  LoginPage({Key key, this.arguments, this.widgetKey})
      : //assert(parentContext != null),
        super(key: key);

  static Route<dynamic> route(BuildContext c, GlobalKey key, {@required args}) {
    final RenderBox box = key.currentContext.findRenderObject();
    final Rect sourceRect = box.localToGlobal(Offset.zero) & box.size;

    return PageRouteBuilder<void>(
        pageBuilder: (BuildContext context, _, __) => ExpandItemPageTransition(
              source: sourceRect,
              child: LoginPage(
                arguments: args,
                widgetKey: key,
              ),
            ),
        transitionDuration: const Duration(milliseconds: 600),
        barrierDismissible: true,
        opaque: false,
        fullscreenDialog: true);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: controller,
      builder: (controller) => AnimatedBuilder(
        animation: controller.animationController,
        builder: (context, child) {
          return Material(
            color: (controller.animation.value as Color),
            child: Center(
              child: Container(
                width: 300,
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      splashRadius: 16,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                    Card(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            //top
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(children: [
                                PimpLeft(
                                  height: 30,
                                  width: 4,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: AutoSizeText(
                                    "Sign In",
                                    minFontSize: 8,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                                ),
                              ]),
                            ),
                            //text
                           
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: MyTextFormField(
                                  hint: "Your e-mail",
                                  validator: (v) {
                                    return (v.isEmpty ||
                                            controller.user.email.isEmpty)
                                        ? '***'
                                        : null;
                                  },
                                  onChange: (v) {
                                    controller.user.email = v;
                                  },
                                  prefixIcon: Icons.email),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: MyTextFormField(
                                  hint: "Create a password",
                                  validator: (v) {
                                    return (v.isEmpty ||
                                            controller.user.password.isPassport)
                                        ? 'A strong password must contain the letters a-z, A-Z, 0-9 digits'
                                        : null;
                                  },
                                  onChange: (v) {
                                    controller.user.password = v;
                                  },
                                  prefixIcon: Icons.password),
                            ),
                           
                            MaterialButton(
                                color: Color(0xff404751),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 45, right: 45, top: 6, bottom: 6),
                                  child: AutoSizeText(
                                    'Sign In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  controller.loginUser();
                                }),

                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Center(
                                child: AutoSizeText(
                                  'OR',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        color: Colors.white12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: MaterialButton(
                                color: Color(0xff404751),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 6, bottom: 6),
                                    child: AutoSizeText(
                                      'Sign In with Google',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: Colors.white),
                                    )),
                                onPressed: () {
                                  controller.googleSignIn();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
