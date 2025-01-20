import 'package:ecom_app/screens/cart_screen.dart';
import 'package:ecom_app/screens/checkout_screen.dart';
import 'package:ecom_app/screens/home_screen.dart';
import 'package:ecom_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home_screen',
  routes: <RouteBase>[
    GoRoute(
      path: '/home_screen',
      name: '/home_screen',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      path: '/product_details_screen/:id',
      name: '/product_details_screen',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['id'];
        return ProductDetailsScreen(
          productId: productId,
        );
      },
    ),
    GoRoute(
      path: '/cart_screen',
      name: '/cart_screen',
      builder: (BuildContext context, GoRouterState state) =>
          const CartScreen(),
    ),
    GoRoute(
      path: '/checkout_screen',
      name: '/checkout_screen',
      builder: (BuildContext context, GoRouterState state) =>
          const CheckoutScreen(),
    ),
  ],
);
