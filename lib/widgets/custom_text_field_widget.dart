import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController? editingController;
  final IconData? iconData;
  final String? labelText;
  final String? assetRef;
  final bool? isObscure;



  CustomTextField({
    super.key,
    this.editingController,
    this.iconData,
    this.labelText,
    this.assetRef,
    this.isObscure,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: iconData != null ? Icon(iconData) : Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(assetRef.toString()),

        ),
        labelStyle: const TextStyle(
          fontSize: 18,

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.cyanAccent,

          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.greenAccent,
          )
        )
      ),
      obscureText:  isObscure!,
    );
  }
}


    