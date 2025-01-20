import 'package:ecom_app/blocs/cart/cart_bloc.dart';
import 'package:ecom_app/blocs/cart/cart_event.dart';
import 'package:ecom_app/blocs/cart/cart_state.dart';
import 'package:ecom_app/blocs/user/user_bloc.dart';
import 'package:ecom_app/blocs/user/user_event.dart';
import 'package:ecom_app/blocs/user/user_state.dart';
import 'package:ecom_app/models/user.dart';
import 'package:ecom_app/util/color/custom_color.dart';
import 'package:ecom_app/widgets/cart_product_view_card.dart';
import 'package:ecom_app/widgets/custom_text_button.dart';
import 'package:ecom_app/widgets/custom_textfield_with_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    contactController.dispose();
    super.dispose();
  }

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
            context.goNamed('/cart_screen');
          },
        ),
        title: Text(
          "Order Confirmation",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartEmpty) {
                return Center(
                  child: Text(
                    'Cart is Empty. Cannot proceed with the order.',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (state is CartLoaded) {
                return BlocBuilder<UserBloc, UserState>(
                  builder: (context, state1) {
                    if (state1 is UserUpdated) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Address Info',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 15),
                          CustomTextfieldWithHeading(
                            heading: 'Name',
                            hintText: state1.users!.name,
                            controller: nameController,
                          ),
                          const SizedBox(height: 12),
                          CustomTextfieldWithHeading(
                            heading: 'Address',
                            hintText: state1.users!.address,
                            controller: addressController,
                          ),
                          const SizedBox(height: 12),
                          CustomTextfieldWithHeading(
                            heading: 'Contact Number',
                            hintText: state1.users!.contactNumber,
                            controller: contactController,
                            keyboadType: TextInputType.phone,
                          ),
                          const SizedBox(height: 35),
                          Text(
                            'Order Summary',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 15),
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const Spacer(),
                                CustomTextButton(
                                  onTap: () {
                                    final user = User(
                                      id: state1.users!.id,
                                      name: nameController.text.trim().isEmpty
                                          ? state1.users!.name
                                          : nameController.text.trim(),
                                      address:
                                          addressController.text.trim().isEmpty
                                              ? state1.users!.address
                                              : addressController.text.trim(),
                                      contactNumber:
                                          contactController.text.trim().isEmpty
                                              ? state1.users!.contactNumber
                                              : contactController.text.trim(),
                                    );

                                    // Add details of the user.
                                    context.read<UserBloc>().add(AddUser(user));

                                    // Payment Confirmation message.
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title:
                                            const Text('Payment Confirmed !'),
                                        content: Text(
                                          'Name: ${user.name}\n'
                                          'Address: ${user.address}\n'
                                          'Contact Number: ${user.contactNumber}\n\n'
                                          'Your payment of \$ ${state.total.toStringAsFixed(2)} is done.',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              // Clear the cart.
                                              context
                                                  .read<CartBloc>()
                                                  .add(ClearCart());
                                              // Return to home screen.
                                              context.goNamed('/home_screen');
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  text: 'Place Order',
                                  fontSize: 16,
                                  width: 130,
                                  height: 40,
                                  borderRadius: 9,
                                  bgColor: CustomColor.red,
                                  textColor: CustomColor.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Text(
                        'User data loading',
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    }
                  },
                );
              } else {
                return AlertDialog(
                  title: const Text('Something went wrong !'),
                  content: const Text('Something went wrong with the data.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}