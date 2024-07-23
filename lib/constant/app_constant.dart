import 'package:flutter/material.dart';

// Font weights
class AppFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight heavy = FontWeight.w900;
}

// Colors
class AppColors {
  static const Color primary = Color(0xFF060623);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF2196F3);
  static const Color amountCard = Color(0xFF2A2A30);
  static const Color grey = Colors.grey;
  static const List<Color> gradientBackgroundColor = [
    Color(0xFF310B47),
    Color(0xFF080626),
    Color(0xFF170621),
    Color(0xFF2C0B47),
    Color(0xFF282065),
  ];
  static const Color expertCard = Color(0xFF1D1D2E);
  static const Color planCard = Color(0xFF16181F);
}

class AppSpacing {
  // Horizontal spacing
  static const SizedBox horizontalExtraSmall = SizedBox(width: 5.0);
  static const SizedBox horizontalSmall = SizedBox(width: 8.0);
  static const SizedBox horizontalMedium = SizedBox(width: 16.0);
  static const SizedBox horizontalLarge = SizedBox(width: 32.0);

  // Vertical spacing
  static const SizedBox verticalExtraSmall = SizedBox(height: 4.0);
  static const SizedBox verticalSmall = SizedBox(height: 8.0);
  static const SizedBox verticalMedium = SizedBox(height: 16.0);
  static const SizedBox verticalLarge = SizedBox(height: 32.0);

  // Dynamic spacing
  static SizedBox horizontal(double width) => SizedBox(width: width);
  static SizedBox vertical(double height) => SizedBox(height: height);
}

// Paddings
class AppPadding {
  static const double extrasmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
}

// Margins
class AppMargin {
  static const double veryExtraSmall = 2.0;
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
}

// Border radii
class AppBorderRadius {
  static const Radius small = Radius.circular(4.0);
  static const Radius medium = Radius.circular(8.0);
  static const Radius large = Radius.circular(16.0);
  static const Radius extraLarge = Radius.circular(32.0);
  static const double circleAvatarRadiusSmall = 30;
  static const double circleAvatarRadius = 40;
}

// Elevations
class AppElevation {
  static const double low = 2.0;
  static const double medium = 6.0;
  static const double high = 12.0;
}

// Thicknesses
class AppThickness {
  static const double thin = 1.0;
  static const double medium = 2.0;
  static const double thick = 4.0;
}

// Icon Sizes
class AppIconSize {
  static const double extrasmall = 8.0;
  static const double small = 16.0;
  static const double medium = 24.0;
  static const double large = 32.0;
  static const double extraLarge = 48.0;
}
