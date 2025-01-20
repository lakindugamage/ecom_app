import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/product_repository.dart';
import '../../models/product.dart';
import 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductLoading()) {

    // Fetch for products.
    on<FetchProducts>(
      (event, emit) async {
        emit(ProductLoading());
        try {
          // Fetch the products from the API.
          final products = await productRepository.fetchProducts();
          emit(ProductLoaded(products));
        } catch (e) {
          emit(
            const ProductError('Failed to fetch products'),
          );
        }
      },
    );

    // Search for products.
    on<SearchProducts>(
      (event, emit) async {
        final currentState = state;
        if (currentState is ProductLoaded) {
          // Fetch the products from the API.
          final products = await productRepository.fetchProducts();
          final filteredProducts = products
              .where(
                (product) => product.name
                    .toLowerCase()
                    .contains(event.query.toLowerCase()),
              )
              .toList();
          emit(
            ProductLoaded(filteredProducts),
          );
        }
      },
    );
    
  }
}
