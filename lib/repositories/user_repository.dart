import 'dart:convert';
import 'package:ecom_app/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<User> fetchUserData() async {
    final String? userUrl = dotenv.env['API_USER_URL'];

    if (userUrl == null || userUrl.isEmpty) {
      throw Exception('API_USER_URL is not set in the environment variables');
    }

    try {
      final Uri url = Uri.parse(userUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load user data: $error');
    }
  }
}
