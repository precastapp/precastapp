import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../util/util.dart';

class CountryFlag extends StatelessWidget {
  String code;
  double? size;
  EdgeInsets padding;
  static var empty = Icon(Icons.flag);

  CountryFlag(this.code,
      {this.size = 48, this.padding = const EdgeInsets.all(kPaddingInternal)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CachedNetworkImage(
        imageUrl: 'https://www.countryflagicons.com/SHINY/64/$code.png',
        fit: BoxFit.fill,
        width: size,
        placeholder: (context, url) => Icon(Icons.flag),
        errorWidget: (context, url, error) => Icon(Icons.flag),
      ),
    );
  }
}
