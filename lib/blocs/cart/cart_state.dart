import 'package:ecom_app/models/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

// After loading the items in the cart.
class CartLoaded extends CartState {
  final List<CartItem> cartProducts;
  final int total;

  const CartLoaded(this.cartProducts, this.total);

  @override
  List<Object?> get props => [cartProducts, total];
}

// Empty the cart.
class CartEmpty extends CartState {}
