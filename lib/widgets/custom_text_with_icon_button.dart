import 'package:ecom_app/util/color/custom_color.dart';
import 'package:flutter/material.dart';

class CustomTextWithIconButton extends StatelessWidget {
  final double? width;
  final double height;
  final IconData icon;
  final Color iconColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? bgColor;
  final double borderRadius;
  final VoidCallback onTap;
  final double iconSize;
  final double gap;

  const CustomTextWithIconButton({
    super.key,
    this.width,
    this.height = 56,
    this.bgColor = CustomColor.ash,
    this.iconColor = CustomColor.white,
    this.borderRadius = 27,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w500,
    required this.icon,
    this.iconSize = 15,
    this.gap = 30,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
            SizedBox(width: gap),
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
