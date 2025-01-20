import 'package:ecom_app/blocs/cart/cart_bloc.dart';
import 'package:ecom_app/blocs/cart/cart_state.dart';
import 'package:ecom_app/util/color/custom_color.dart';
import 'package:ecom_app/widgets/cart_product_view_card.dart';
import 'package:ecom_app/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          child: Container(
            color: CustomColor.transparent, // Increase touch area.
            child: const Icon(
              FontAwesomeIcons.chevronLeft,
            ),
          ),
          onTap: () {
            context.goNamed('/home_screen');
          },
        ),
        title: Text(
          "My Cart",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (BuildContext context, CartState state) {
              if (state is CartEmpty) {
                return Center(
                  child: Text(
                    'Cart is Empty',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                );
              } else if (state is CartLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cartProducts.length,
                        itemBuilder: (context, index) {
                          final product = state.cartProducts[index];
                          return CartProductViewCard(product: product);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            'Total: \$ ${state.total.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const Spacer(),
                          CustomTextButton(
                            onTap: () {
                              context.goNamed('/checkout_screen');
                            },
                            text: 'Checkout',
                            fontSize: 16,
                            width: 121,
                            height: 40,
                            borderRadius: 9,
                            bgColor: CustomColor.ligthBlack,
                            textColor: CustomColor.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Something went wrong.'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}


