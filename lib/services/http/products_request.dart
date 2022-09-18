import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../network/api_url.dart';

class ProductsRequest {
  ProductsRequest._init();
  static Future<String?> fetchProducts({Map<String, String>? headers}) async {
    final uri = Uri.parse(ApiUrls.baseUrl);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }
}
