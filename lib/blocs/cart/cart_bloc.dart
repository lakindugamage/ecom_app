import 'package:ecom_app/models/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty()) {
    // Add items to the cart.
    on<AddToCart>((event, emit) {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        late Iterable<CartItem> updatedProducts;
        final currentProductList =
            List<CartItem>.from(currentState.cartProducts);

        // Check whether the item is currently added to the cartProducts list.
        if (currentProductList
            .any((product) => product.id == event.cartProducts.id)) {
          // Initailize the updated products list.
          updatedProducts = currentProductList;
          // Increment product qunatity without adding the item to the updated products list.
          updatedProducts = updatedProducts.map((product) {
            if (event.cartProducts.id == product.id) {
              var tempProduct = CartItem(
                id: product.id,
                description: product.description,
                image: product.image,
                name: product.name,
                price: product.price,
                qunatity: product.qunatity + 1,
              );
              return tempProduct;
            } else {
              return product;
            }
          });
        }
        // Add item to the update products list.
        else {
          updatedProducts = currentProductList..add(event.cartProducts);
        }
        // Get the total value of the updated products list.
        final total = updatedProducts.fold(
            0, (sum, product) => sum + product.price * product.qunatity);
        emit(CartLoaded(updatedProducts.toList(), total));
      } else {
        emit(CartLoaded([event.cartProducts], event.cartProducts.price));
      }
    });

    // Increment product qunatity.
    on<IncrementProductQuantity>((event, emit) {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final addedProduct = event.cartProducts;
        Iterable<CartItem> updatedProducts =
            List<CartItem>.from(currentState.cartProducts);
        updatedProducts = updatedProducts.map((product) {
          if (addedProduct.id == product.id) {
            var tempProduct = CartItem(
              id: product.id,
              description: product.description,
              image: product.image,
              name: product.name,
              price: product.price,
              qunatity: product.qunatity + 1, // Increment the qunatity
            );
            return tempProduct;
          } else {
            return product;
          }
        });
        // Total value in the cart.
        final total = updatedProducts.fold(
            0, (sum, product) => sum + product.price * product.qunatity);
        emit(CartLoaded(updatedProducts.toList(), total));
      } else {
        emit(CartLoaded([event.cartProducts], event.cartProducts.price));
      }
    });

    // Decrement product qunatity.
    on<DecrementProductQuantity>((event, emit) {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final addedProduct = event.cartProducts;
        Iterable<CartItem> updatedProducts =
            List<CartItem>.from(currentState.cartProducts);
        updatedProducts = updatedProducts.map((product) {
          if (addedProduct.id == product.id) {
            var tempProduct = CartItem(
              id: product.id,
              description: product.description,
              image: product.image,
              name: product.name,
              price: product.price,
              qunatity: product.qunatity - 1, // Decrement the qunatity.
            );
            return tempProduct;
          } else {
            return product;
          }
        });
        // Total value in the cart.
        final total = updatedProducts.fold(
            0, (sum, product) => sum + product.price * product.qunatity);
        emit(CartLoaded(updatedProducts.toList(), total));
      } else {
        emit(CartLoaded([event.cartProducts], event.cartProducts.price));
      }
    });

    // Remove items from the cart.
    on<RemoveFromCart>((event, emit) {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final updatedProducts = List<CartItem>.from(currentState.cartProducts)
          ..remove(event.cartProducts);
        final total = updatedProducts.fold(
            0, (sum, product) => sum + product.price * product.qunatity);
        if (updatedProducts.isEmpty) {
          emit(CartEmpty());
        } else {
          emit(CartLoaded(updatedProducts, total));
        }
      }
    });

    // Clear items from the cart.
    on<ClearCart>((event, emit) => emit(CartEmpty()));
  }
}
