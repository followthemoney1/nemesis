import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/widgets/my_text_field.dart';

import 'chat_controller.dart';

class ChatWidget extends GetView<ChatController> {
  late String tag;
  ChatWidget({required matchId}) : super() {
    this.tag = matchId;
    ChatController imageController =
        Get.put<ChatController>(ChatController(matchId: matchId), tag: tag);
  }

  get controller => Get.find<ChatController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      tag: tag,
      init: controller,
      builder: (_) => Container(
        child: Column(children: [
          Flexible(
            child: ListView(
              children: controller.messages
                  .map<Widget>(
                    (element) => Card(
                      color: NewsThemeData.buttonMainColor,
                      child: AutoSizeText(
                        element.content ?? "",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          !controller.showSendMessage()
              ? Container(
                  child: Text('Login first to send message'),
                )
              : Row(children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: MyTextFormField(
                          endbled: controller.canSendMessage,
                          hint: "Write a message",
                          prefixIcon: Icons.message_rounded,
                          validator: (v) {},
                          controller: controller.editingController,
                          onChange: (val) {
                            // controller.message = val;
                          }),
                    ),
                  ),
                  MaterialButton(
                      child: Icon(Icons.send_rounded),
                      onPressed: () {
                        //send
                        controller.sendMessage();
                        controller.editingController.clear();
                      })
                ]),
        ]),
      ),
    );
  }
}
