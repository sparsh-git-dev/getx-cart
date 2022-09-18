import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/product_model.dart';
import '../services/local_database/local_database_helper.dart';

class MyCartScreenVM extends GetxController {
  List productsInCart = [];
  int totalItems = 0;
  int grandTotal = 0;
  bool isLoading = false;

  void checkProductsInCartFromDB() async {
    isLoading = true;
    update();
    List data = await LocalDBHelper.instance.queryAllRows();
    if (data.isNotEmpty) {
      for (Map<String, dynamic> element in data) {
        totalItems += element['quantity'] as int;
        grandTotal += element['price'] as int;
        productsInCart.add(Datum.fromJson(element));
      }
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    checkProductsInCartFromDB();
    super.onInit();
  }
}
