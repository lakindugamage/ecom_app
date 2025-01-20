import 'package:ecom_app/util/color/custom_color.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final double? width;
  final double height;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? bgColor;
  final double borderRadius;
  final VoidCallback onTap;
  final bool isActive;

  const CustomTextButton({
    super.key,
    this.width,
    this.height = 56,
    this.bgColor = CustomColor.blue,
    this.borderRadius = 27,
    required this.onTap,
    required this.text,
    this.textColor = Colors.black,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w700,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? deviceWidth,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
