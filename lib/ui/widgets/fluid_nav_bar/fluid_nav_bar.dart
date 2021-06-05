import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/ui/header/header.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_controller.dart';

class FluidNavBar extends GetWidget<FluidController> {
  Function(int)? onChange;
  final Color backgroundColor = Color(0xFF363c45);
  FluidNavBar({Function(int)? onChange}) {
    this.onChange = onChange;
  }
  final controller = Get.put(FluidController());
  late var context;
  @override
  Widget build(BuildContext context) {
    this.context = context;

    return GetBuilder<FluidController>(
      init: controller,
      builder: (_) => AnimatedSize(
        vsync: controller,
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
          child: GestureDetector(
            //  onTap: onChange(0),
            child: Column(
              children: [
                icon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget icon() {
    return Container(
      width: controller.nominalWidth,
      height: Header.topHeight,
      
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          controller.widthChange
              ? BoxShadow(color: Colors.transparent)
              : BoxShadow(
                  color: Colors.black38,
                  blurRadius: 12.0,
                  offset: Offset(4, -1),
                )
        ],
      ),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).cardTheme.color),
          shadowColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () {
          controller.click();
        },
        child:AnimatedAlign(
        duration: const Duration(milliseconds: 400), 
        alignment: controller.widthChange ? Alignment.centerLeft: Alignment.center ,
        child:Container(width:Header.topHeight,child: Icon(Icons.ac_unit,),),),
      ),
    );
  }
}
