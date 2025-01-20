import 'package:ecom_app/blocs/product/product_bloc.dart';
import 'package:ecom_app/blocs/product/product_event.dart';
import 'package:ecom_app/util/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({super.key});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      child: TextFormField(
        onChanged: (query) {
          context.read<ProductBloc>().add(SearchProducts(query));
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode ? CustomColor.ligthBlack : CustomColor.white,
          labelText: 'Search Products',
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
