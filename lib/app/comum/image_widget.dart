import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

imageWidget(String path, double radius, AlignmentGeometry align) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    child: Image.asset(
      path,
      height: double.maxFinite,
      width: double.maxFinite,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      alignment: align,
    ),
  );
}

imageShimmerWidget(String path, double radius, AlignmentGeometry align) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    child: Image.asset(
      path,
      height: double.maxFinite,
      width: double.maxFinite,
      fit: BoxFit.fitWidth,
      filterQuality: FilterQuality.high,
      alignment: align,
    ),
  )
      .animate(onPlay: (c) => c.repeat())
      .shimmer(delay: const Duration(seconds: 8), color: Colors.white);
}
