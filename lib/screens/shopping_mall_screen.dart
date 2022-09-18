import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/my_cart_screen.dart';
import 'package:get/get.dart';
import '../utils/extensions.dart';
import '../view_model/shopping_mall_view_model.dart';
import '../widgets/product_grid_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShoppingMallScreen extends StatelessWidget {
  const ShoppingMallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GetBuilder<ShoppingMallVM>(
          init: ShoppingMallVM(),
          builder: (ShoppingMallVM controller) {
            return controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : controller.products.isEmpty
                    ? const Center(
                        child: Text(_noProducts),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 24.0,
                          ),
                          child: StaggeredGrid.count(
                            crossAxisCount:
                                context.appOrientation == Orientation.landscape
                                    ? _mainAxisCount
                                    : _crossAxisCount,
                            mainAxisSpacing: _axisSpacing,
                            crossAxisSpacing: _axisSpacing,
                            children: [
                              for (var product in controller.products)
                                ProductGridWidget(
                                  imgUrl: product.featuredImage,
                                  onTap: () => controller.addToCart(product),
                                  productName: product.title,
                                )
                            ],
                          ),
                        ),
                      );
          }),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(_appBarTitle, style: context.appTextTheme.headline1),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GetBuilder<ShoppingMallVM>(
                init: ShoppingMallVM(),
                builder: (ShoppingMallVM controller) {
                  return GestureDetector(
                    onTap: () => Get.to(() => const MyCartScreen()),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart),
                        Text(
                          controller.totalItems.toString(),
                          style: context.appTextTheme.small1.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      );
}

const String _appBarTitle = 'Shopping Mall';
const String _noProducts = 'No Products';
const double _axisSpacing = 16.0;
const int _crossAxisCount = 2;
const int _mainAxisCount = 3;
