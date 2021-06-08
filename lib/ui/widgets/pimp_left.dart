import 'package:flutter/material.dart';

class PimpLeft extends StatelessWidget {
  final height;
  final width;
  const PimpLeft({this.width,this.height,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds:300),
       height:height,
      width: width,
       decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10)
      ),
     
      color: Theme.of(context).colorScheme.primary
    ),
    );
  }
}