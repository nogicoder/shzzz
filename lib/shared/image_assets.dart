import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// [ImageAssets] provides ready-to-use variables represent local icons and
/// various methods to display svg and local images
class ImageAssets {
  static String? package;
  static const image_path = 'assets/image';
  static const svg_path = 'assets/svg';

  static const flag_vi = '$image_path/flag_vi.png';
  static const flag_en = '$image_path/flag_en.png';
  static const ic_empty = '$svg_path/ic_empty.svg';

  static const ic_logo = '$svg_path/ic_logo.svg';

  //! Get placeholder image
  static String getTestImage(int width, [int height = 0]) {
    return 'https://picsum.photos/$width${height > 0 ? '/$height' : ''}?x=${Random().nextInt(100)}';
  }

  /// Display an svg asset using [SvgPicture.asset]
  static SvgPicture svgAssets(
    String name, {
    Color? color,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      name,
      color: color,
      width: width,
      height: height,
      fit: fit,
      package: package,
    );
  }

  /// Display an svg network asset using [SvgPicture.network]
  static Widget svgUrl(String name,
      {Color? color,
      double? width,
      double? height,
      bool circle = false,
      Widget? placeholderWidget,
      BoxFit fit = BoxFit.contain,
      EdgeInsets padding = const EdgeInsets.all(6.0)}) {
    return Padding(
      padding: padding,
      child: SvgPicture.network(
        name,
        color: color,
        fit: fit,
        placeholderBuilder: (context) => placeholderWidget ?? Container(),
        width: width,
        height: height,
      ),
    );
  }

  /// Display a local image asset using [Image.asset]
  static Widget pngAsset(String name,
      {Color? color,
      double? width,
      double? height,
      bool circle = false,
      Widget? placeholderWidget,
      EdgeInsets padding = const EdgeInsets.all(6.0)}) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          CupertinoActivityIndicator(),
          SizedBox(
            width: width,
            height: height,
            child: Image.asset(
              name,
              color: color,
              package: package,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  /// Display network images using [CachedNetworkProvider]. Display a
  /// [CupertinoActivityIndicator] on top when loading
  static Widget networkImage(
      {String? url,
      double? width,
      double? height,
      BoxFit? fit,
      bool getTestImage = true}) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          CupertinoActivityIndicator(),
          CachedNetworkImage(
            imageUrl:
                url ?? (getTestImage ? ImageAssets.getTestImage(512) : ''),
            fit: fit ?? BoxFit.cover,
            errorWidget: (context, error, _) {
              return getTestImage
                  ? Image.network(ImageAssets.getTestImage(512),
                      fit: BoxFit.cover)
                  : Container(color: Get.theme.cardColor);
            },
          ),
        ],
      ),
    );
  }
}
