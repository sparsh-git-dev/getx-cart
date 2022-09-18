import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../utils/extensions.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({
    super.key,
    required Function() onTap,
    required final String imgUrl,
    required final String productName,
  })  : _imgUrl = imgUrl,
        _onTap = onTap,
        _productName = productName;

  final String _imgUrl;
  final String _productName;
  final Function() _onTap;

  @override
  Widget build(BuildContext context) => _buildBody(context);

  Widget _buildBody(BuildContext context) => Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 6.0,
        child: Column(
          children: [
            _getTopContainer(_imgUrl, context),
            _getBottomContainer(_productName, _onTap, context),
          ],
        ),
      );

  Widget _getTopContainer(String imgUrl, BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(_circularBorder),
            topLeft: Radius.circular(_circularBorder),
          ),
        ),
        child: CachedNetworkImage(
          height: context.appOrientation == Orientation.landscape
              ? context.width * 0.25
              : context.width * 0.35,
          width: double.infinity,
          imageUrl: imgUrl,
          fit: BoxFit.fill,
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

  Widget _getBottomContainer(
    String productName,
    Function() onTap,
    BuildContext context,
  ) =>
      Container(
        decoration: const BoxDecoration(
          color: AppColors.secondaryAccentColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(_circularBorder),
            bottomLeft: Radius.circular(_circularBorder),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                productName,
                maxLines: 1,
                style: context.appTextTheme.small1,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: const Icon(
                Icons.shopping_cart,
                size: 24,
                color: AppColors.accentColor,
              ),
            ),
          ],
        ),
      );
}

const double _circularBorder = 18.0;
