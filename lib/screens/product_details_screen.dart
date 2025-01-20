import 'package:ecom_app/blocs/cart/cart_bloc.dart';
import 'package:ecom_app/blocs/cart/cart_event.dart';
import 'package:ecom_app/blocs/product/product_bloc.dart';
import 'package:ecom_app/models/cart_item.dart';
import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/util/color/custom_color.dart';
import 'package:ecom_app/widgets/custom_text_with_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String? productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
          ),
          onTap: () {
            context.goNamed('/home_screen');
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          state.products
                              .where((product) => product.id == productId)
                              .first
                              .image,
                          height: 250,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      state.products
                          .where((product) => product.id == productId)
                          .first
                          .name,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$ ${state.products.where((product) => product.id == productId).first.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.products
                          .where((product) => product.id == productId)
                          .first
                          .description,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 5, 40, 20),
                      child: Center(
                        child: CustomTextWithIconButton(
                          onTap: () async {
                            try {
                              final product = Product(
                                id: productId!,
                                name: state.products
                                    .where((product) => product.id == productId)
                                    .first
                                    .name,
                                description: state.products
                                    .where((product) => product.id == productId)
                                    .first
                                    .description,
                                price: state.products
                                    .where((product) => product.id == productId)
                                    .first
                                    .price,
                                image: state.products
                                    .where((product) => product.id == productId)
                                    .first
                                    .image,
                              );
                              context.read<CartBloc>().add(
                                    AddToCart(
                                      CartItem(
                                        id: product.id,
                                        description: product.description,
                                        image: product.image,
                                        name: product.name,
                                        price: product.price,
                                        qunatity: 1,
                                      ),
                                    ),
                                  );

                              // Notifying user that the product is added to the cart.
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Added to the cart',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  backgroundColor: CustomColor.green,
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Cannot add product to the cart',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          text: "Add to Cart",
                          icon: FontAwesomeIcons.cartShopping,
                          fontSize: 18,
                          height: 45,
                          width: 200,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Failed to load products'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
