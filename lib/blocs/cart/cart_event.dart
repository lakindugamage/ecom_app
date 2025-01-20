import 'package:ecom_app/models/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

// Add products to the cart
class AddToCart extends CartEvent {
  final CartItem cartProducts;

  const AddToCart(this.cartProducts);

  @override
  List<Object?> get props => [cartProducts];
}

// Remove items from the cart.
class RemoveFromCart extends CartEvent {
  final CartItem cartProducts;

  const RemoveFromCart(this.cartProducts);

  @override
  List<Object?> get props => [cartProducts];
}

// Clear the cart.
class ClearCart extends CartEvent {}

// Increment qunatity.
class IncrementProductQuantity extends CartEvent {
  final CartItem cartProducts;

  const IncrementProductQuantity(this.cartProducts);

  @override
  List<Object?> get props => [cartProducts];
}

// Decrement qunatity.
class DecrementProductQuantity extends CartEvent {
  final CartItem cartProducts;

  const DecrementProductQuantity(this.cartProducts);

  @override
  List<Object?> get props => [cartProducts];
}
