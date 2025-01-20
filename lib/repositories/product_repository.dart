import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final String? productUrl = dotenv.env['API_PRODUCT_URL'];

    if (productUrl == null || productUrl.isEmpty) {
      throw Exception(
          'API_PRODUCT_URL is not set in the environment variables');
    }

    try {
      final Uri url = Uri.parse(productUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load products: $error');
    }
  }
}
