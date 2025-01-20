import 'package:ecom_app/blocs/cart/cart_bloc.dart';
import 'package:ecom_app/blocs/cart/cart_event.dart';
import 'package:ecom_app/blocs/cart/cart_state.dart';
import 'package:ecom_app/blocs/product/product_bloc.dart';
import 'package:ecom_app/models/cart_item.dart';
import 'package:ecom_app/util/color/custom_color.dart';
import 'package:ecom_app/widgets/custom_snack_bar.dart';
import 'package:ecom_app/widgets/custom_textfield.dart';
import 'package:ecom_app/widgets/product_view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Ecom",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () {
                context.goNamed('/cart_screen');
              },
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    // Show the badge only if there are items in the cart.
                    return badges.Badge(
                      showBadge: state.cartProducts.isNotEmpty,
                      badgeContent: Padding(
                        // Align the text to the center of the circle.
                        padding: const EdgeInsets.only(bottom: 2, right: 1.5),
                        child: Text(
                          state.cartProducts.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      position: badges.BadgePosition.topEnd(top: -15, end: -20),
                      child: const Icon(
                        FontAwesomeIcons.cartShopping,
                        size: 20,
                        color: CustomColor.grey,
                      ),
                    );
                  } else {
                    // Hide the badge by default if the state is unhandled.
                    return const Icon(
                      FontAwesomeIcons.cartShopping,
                      size: 20,
                      color: CustomColor.grey,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: CustomTextfield(), // Search products.
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductLoaded) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductViewCard(
                          product: product,
                          onTap: () {
                            context.go('/product_details_screen/${product.id}');
                          },
                          addToCart: () {
                            // Add item to the cart.
                            context.read<CartBloc>().add(
                                  AddToCart(
                                    CartItem(
                                      id: product.id,
                                      name: product.name,
                                      description: product.description,
                                      price: product.price,
                                      image: product.image,
                                      qunatity: 1,
                                    ),
                                  ),
                                );
                            // Alert the user when adding items to the cart.
                            ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar(
                                message: 'Addded to the cart',
                                backgroundColor: CustomColor.green,
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Failed to load products'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
