import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class ProductInCart extends StatelessWidget {
  const ProductInCart({
    super.key,
    required final int quantity,
    required final int cost,
    required final String imgUrl,
    required final String productName,
  })  : _imgUrl = imgUrl,
        _quantity = quantity,
        _cost = cost,
        _productName = productName;

  final String _imgUrl;
  final String _productName;
  final int _cost;
  final int _quantity;

  @override
  Widget build(BuildContext context) => _buildBody();

  Widget _buildBody() => Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 6.0,
        child: Row(
          children: [
            _getLeftContainer(_imgUrl),
            _getRightContainer(),
          ],
        ),
      );

  Widget _getLeftContainer(imgUrl) => Container(
        height: 140,
        decoration: const BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_circularBorder),
            topLeft: Radius.circular(_circularBorder),
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          progressIndicatorBuilder: (
            context,
            url,
            downloadProgress,
          ) =>
              const Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );

  Widget _getRightContainer() => Expanded(
        child: Container(
          height: 140,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 18,
          ).copyWith(right: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(_circularBorder),
              bottomRight: Radius.circular(_circularBorder),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_productName),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Price"),
                  Text(
                    "$_currency$_cost",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Quantity"),
                  Text(
                    "$_quantity",
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

const double _circularBorder = 8.0;
const String _currency = '\$';
