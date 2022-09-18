import 'dart:convert';
import 'package:get/get.dart';
import '../model/product_model.dart';
import '../services/http/products_request.dart';
import '../services/local_database/local_database_helper.dart';

class ShoppingMallVM extends GetxController {
  bool isLoading = false;
  int totalItems = 0;
  List<Datum> products = [];
  List<Datum> productsInCart = [];

  void addToCart(Datum product) async {
    bool isProductExist = false;
    for (var element in productsInCart) {
      if (element.id == product.id) {
        isProductExist = true;
      }
    }

    if (isProductExist) {
      await LocalDBHelper.instance.updateQuantity(product.id);
    } else {
      await LocalDBHelper.instance.insert(product);
    }
    totalItems++;
    productsInCart.add(product);
    update();
  }

  void fetchProducts() async {
    isLoading = true;
    update();

    final String? response = await ProductsRequest.fetchProducts();
    if (response != null) {
      final ProductModel productModel =
          ProductModel.fromJson(jsonDecode(response)[0]);
      products = productModel.data.toList();
    }

    isLoading = false;

    update();
  }

  void checkProductsInCart() async {
    List data = await LocalDBHelper.instance.queryAllRows();
    if (data.isNotEmpty) {
      for (var element in data) {
        productsInCart.add(Datum.fromJson(element));
        totalItems += element['quantity'] as int;
      }
      update();
    }
  }

  @override
  void onInit() {
    fetchProducts();
    checkProductsInCart();
    super.onInit();
  }
}
