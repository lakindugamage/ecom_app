import 'package:ecom_app/util/color/custom_color.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String message,
    required Color super.backgroundColor,
    super.duration = const Duration(milliseconds: 800),
  }) : super(
          content: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: CustomColor.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
}
