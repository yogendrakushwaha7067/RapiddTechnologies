import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'common_app_shimmer.dart';

class ReusableImageWithShimmer extends StatelessWidget {
  const ReusableImageWithShimmer({
    Key? key,
    required this.url,
    required this.height,
    this.onTap,
    this.isCircle = true,
    this.boxFit = BoxFit.contain,
    this.placeholderUrl = 'assets/images/no_image.png',
    this.isBackDrop = false,
    this.borderRadius = 0.0,
    this.width,
  }) : super(key: key);
  final double height;
  final String url;
  final bool isCircle;
  final bool isBackDrop;
  final BoxFit boxFit;
  final String placeholderUrl;
  final void Function()? onTap;
  final double borderRadius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(isCircle ? height / 2 : borderRadius),
        child: SizedBox(
          height: height,
          width: width ?? height,
          child: CachedNetworkImage(
            imageUrl: url,
            errorWidget: (context, url, error) {
              return ClipRRect(
                borderRadius:
                    BorderRadius.circular(isCircle ? height / 2 : borderRadius),
                child: Image.asset(
                  placeholderUrl,
                  fit: boxFit,
                ),
              );
            },
            fit: boxFit,
            placeholder: (context, url) {
              return isCircle
                  ? CommonAppShimmer.circular(height: height)
                  : CommonAppShimmer.rectangular(height: height);
            },
          ),
        ),
      ),
    );
  }
}
