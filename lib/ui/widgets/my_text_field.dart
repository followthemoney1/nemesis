import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final IconData prefixIcon;
  final String hint;
  final FormFieldValidator validator;
  final Function(String val) onChange;
  final TextEditingController? controller;
  final bool endbled;
  const MyTextFormField({this.endbled = true, required String this.hint,required IconData this.prefixIcon, Key? key,required FormFieldValidator this.validator,required this.onChange, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: endbled,
      style: Theme.of(context)
          .textTheme
          .caption!
          .copyWith(color: Colors.white, fontSize: 10),
      validator: validator,//(value) => (value.isEmpty) ? '**' : null,
      onChanged: onChange,
      decoration: InputDecoration(
        
        prefixIcon: Icon(prefixIcon),
        contentPadding:
            EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        isDense: true,
        hintText: hint,
        // errorText: "Field isn't correct",
        fillColor: Color(0xFF293039),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          borderSide: BorderSide(
            color: Color(0xFF293039),
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary)),
        filled: true,
      ),
    );
  }
}
