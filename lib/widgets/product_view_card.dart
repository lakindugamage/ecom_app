import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/util/color/custom_color.dart';
import 'package:ecom_app/widgets/custom_text_with_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductViewCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback addToCart;

  const ProductViewCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 120,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        color: isDarkMode ? CustomColor.ligthBlack : CustomColor.lightSilver,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              Text(
                product.name,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 7),
              Text(
                '\$ ${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              CustomTextWithIconButton(
                onTap: addToCart,
                text: 'Add to cart',
                icon: FontAwesomeIcons.cartShopping,
                width: 102,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                iconSize: 10,
                height: 25,
                gap: 7,
                bgColor: CustomColor.white,
                textColor: CustomColor.black,
                iconColor: CustomColor.black,
              ),
              const SizedBox(height: 7),
            ],
          ),
        ],
      ),
    );
  }
}
