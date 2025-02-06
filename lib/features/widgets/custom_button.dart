import 'package:admin_panel/core/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        this.buttonText = "Button",
        required this.onPressed,
        this.isLoading = false,
        this.height = 40.0,
        this.bgColor, this.textStyle});

  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;
  final double height;
  final Color? bgColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      color: bgColor ?? deepBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () => isLoading ? null : onPressed(),
      child: isLoading
          ? SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      )
          : Text(buttonText, style: textStyle ?? TextStyle(
        color: Colors.white
      ), textAlign: TextAlign.center),
    );
  }
}