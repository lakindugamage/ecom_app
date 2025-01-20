import 'package:ecom_app/blocs/cart/cart_bloc.dart';
import 'package:ecom_app/blocs/cart/cart_event.dart';
import 'package:ecom_app/models/cart_item.dart';
import 'package:ecom_app/util/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartProductViewCard extends StatefulWidget {
  final CartItem product;

  const CartProductViewCard({
    super.key,
    required this.product,
  });
  @override
  State<CartProductViewCard> createState() => _CartProductViewCardState();
}

class _CartProductViewCardState extends State<CartProductViewCard> {
  // Increment product qunatity.
  void _incrementCounter() {
    context.read<CartBloc>().add(IncrementProductQuantity(widget.product));
  }

  // Decrement product qunatity.
  void _decrementCounter() {
    if (widget.product.qunatity > 1) {
      context.read<CartBloc>().add(DecrementProductQuantity(widget.product));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 120,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: isDarkMode ? CustomColor.ligthBlack : CustomColor.lightSilver,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.product.image,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              Text(
                widget.product.name,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 7),
              Text(
                '\$ ${widget.product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColor.white,
                    ),
                    // Product qunatity change.
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _incrementCounter();
                          },
                          child: Container(
                            width: 30,
                            color: CustomColor
                                .transparent, // To increase clicking area.
                            child: const Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: CustomColor.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          widget.product.qunatity.toString(),
                          style: const TextStyle(
                            color: CustomColor.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _decrementCounter();
                          },
                          child: Container(
                            width: 30,
                            color: CustomColor
                                .transparent, // To increase clicking area.
                            child: const Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Remove product.
                  IconButton(
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(RemoveFromCart(widget.product));
                    },
                    icon: const Icon(
                      FontAwesomeIcons.trash,
                      color: CustomColor.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
