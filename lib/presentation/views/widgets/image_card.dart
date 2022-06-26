import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psgames/constants/assets.dart';
import 'package:psgames/utils/device_utils.dart';

class ImageCard extends StatelessWidget {
  final String? imageUrl;
  final double? borderRadius;
  final double? heightScale;
  final double? widthScale;
  final double? shadowBlurRadius;
  final double? shadowSpreadRadius;
  const ImageCard(
      {Key? key,
      this.imageUrl,
      this.borderRadius,
      this.heightScale,
      this.widthScale,
      this.shadowBlurRadius,
      this.shadowSpreadRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: DeviceUtils.getScaledHeight(context, 0.02),
          bottom: DeviceUtils.getScaledHeight(context, 0.01)),
      width: DeviceUtils.getScaledWidth(context, widthScale ?? 0.6),
      height: DeviceUtils.getScaledHeight(context, heightScale ?? 0.45),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 2),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: shadowBlurRadius ?? 6,
                spreadRadius: shadowSpreadRadius ?? 5,
                offset: Offset(2, 4),
                color: Colors.black.withOpacity(0.15))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 2),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? Assets.image_not_available,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Center(child: Container()
              // Image.asset(
              //   Assets.image_not_available,
              //   fit: BoxFit.fitWidth,
              // ),
              ),
        ),
      ),
    );
  }
}
