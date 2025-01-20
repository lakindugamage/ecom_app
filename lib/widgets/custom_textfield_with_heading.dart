import 'package:ecom_app/util/color/custom_color.dart';
import 'package:flutter/material.dart';

class CustomTextfieldWithHeading extends StatefulWidget {
  final String heading;
  final String? hintText;
  final Color hintTextColor;
  final double hintTextSize;
  final double borderRadius;
  final double? width;
  final TextInputType keyboadType;
  final TextEditingController controller;

  const CustomTextfieldWithHeading({
    super.key,
    required this.heading,
    this.hintText,
    this.hintTextColor = CustomColor.grey,
    this.hintTextSize = 16,
    this.borderRadius = 9,
    this.width,
    this.keyboadType = TextInputType.text,
    required this.controller,
  });

  @override
  State<CustomTextfieldWithHeading> createState() =>
      _CustomTextfieldWithHeadingState();
}

class _CustomTextfieldWithHeadingState
    extends State<CustomTextfieldWithHeading> {
      
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: widget.width ?? MediaQuery.sizeOf(context).width,
          child: TextFormField(
            controller: widget.controller,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: widget.keyboadType,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDarkMode ? CustomColor.darkBlack : CustomColor.white,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.hintTextColor,
                fontSize: widget.hintTextSize,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkMode ? CustomColor.grey : CustomColor.darkBlack,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
