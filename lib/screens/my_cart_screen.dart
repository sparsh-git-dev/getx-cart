import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/extensions.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';
import '../resources/app_colors.dart';
import '../view_model/my_cart_screen_view_model.dart';
import '../widgets/product_in_cart.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        bottomNavigationBar: _bottomNavBar(context),
        body: GetBuilder(
            init: MyCartScreenVM(),
            builder: (MyCartScreenVM controller) {
              return controller.productsInCart.isEmpty
                  ? Center(
                      child: Text(
                        "Cart is empty",
                        style: context.appTextTheme.small1,
                      ),
                    )
                  : controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 36.0,
                          ),
                          shrinkWrap: false,
                          itemCount: controller.productsInCart.length,
                          itemBuilder: (context, index) {
                            final Datum product =
                                controller.productsInCart[index];

                            return ProductInCart(
                              cost: product.price,
                              productName: product.title,
                              quantity: product.quantity,
                              imgUrl: product.featuredImage,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 22.0,
                            );
                          },
                        );
            }));
  }

  Widget _bottomNavBar(BuildContext context) => Container(
        color: AppColors.bottomNavBarColor,
        child: GetBuilder(
            init: MyCartScreenVM(),
            builder: (MyCartScreenVM controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 14.0,
                ),
                child: Row(
                  children: [
                    Text(
                      'Total Items :  ${controller.totalItems}',
                      style: context.appTextTheme.small1,
                    ),
                    const Spacer(),
                    Text(
                      'Grand Total : ',
                      style: context.appTextTheme.small1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        controller.grandTotal.toString(),
                        style: context.appTextTheme.small1,
                      ),
                    ),
                  ],
                ),
              );
            }),
      );

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(_appBarTitle, style: context.appTextTheme.headline1),
        centerTitle: true,
      );
}

const String _appBarTitle = "My Cart";
