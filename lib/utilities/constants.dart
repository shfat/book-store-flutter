import 'package:flutter/material.dart';

/// Centralized color palette used throughout the bookstore application.
///
/// Keeping colors in one place improves consistency, maintainability,
/// and makes future theme customization easier.
const kBackgroundColor = Color(0xFF0F0F1A);
const kSurfaceColor = Color(0xFF1A1A2E);
const kSurfaceLightColor = Color(0xFF2A2A42);
const kPrimaryColor = Color(0xFF6C63FF);
const kPrimaryLightColor = Color(0xFF8B83FF);
const kPrimaryDarkColor = Color(0xFF3D3B8A);
const kTextColor = Color(0xFFE0E0E0);
const kTextSecondaryColor = Color(0xFF9E9E9E);
const kTextLightColor = Color(0xFFB8B5FF);
const kBorderColor = Color(0xFF33334D);
const kErrorColor = Color(0xFFFF6B6B);

/// Typography styles used for different text hierarchies across the app.
const kTitleTextStyle = TextStyle(
  color: kTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 26,
);

const kTitleSmallTextStyle = TextStyle(
  color: kTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const kCardTitleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: kTextColor,
  fontSize: 14,
);

const kAuthorTextStyle = TextStyle(
  color: kTextSecondaryColor,
  fontSize: 12,
);

const kPriceTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 13,
);

const kDrawerTextStyle = TextStyle(
  color: kTextColor,
);

const kDrawerHeaderTextStyle = TextStyle(
  color: kTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const kDrawerEmailTextStyle = TextStyle(
  color: kTextLightColor,
  fontSize: 14,
);

/// Text styles dedicated to dialog components.
const kDialogTitleTextStyle = TextStyle(
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kDialogContentTextStyle = TextStyle(
  color: kTextSecondaryColor,
  fontSize: 15,
);

const kDialogButtonTextStyle = TextStyle(
  color: kTextSecondaryColor,
  fontWeight: FontWeight.w500,
);

/// Book details screen text styles.
const kBookTitleTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);

const kBookAuthorTextStyle = TextStyle(
  fontSize: 16,
  color: kTextSecondaryColor,
);

const kBookDescriptionTextStyle = TextStyle(
  fontSize: 15,
  height: 1.6,
  color: kTextLightColor,
);

const kBookPriceTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);

/// Order-related text styles used in checkout and order history screens.
const kOrderTitleTextStyle = TextStyle(
  color: kTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

const kOrderTotalTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

/// About page typography styles.
const kAboutTitleTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);

const kAboutDescriptionTextStyle = TextStyle(
  fontSize: 15,
  height: 1.7,
  color: kTextSecondaryColor,
);

const kAboutHeadingTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);

const kAboutSubtitleTextStyle = TextStyle(
  color: kTextSecondaryColor,
  fontSize: 14,
  height: 1.8,
);

/// Reusable button styles shared between different application screens.
final kPrimaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);

final kErrorButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kErrorColor,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);

final kGradientButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.transparent,
  shadowColor: Colors.transparent,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
);

/// Gradient definitions used for visual elements and themed components.
const kPrimaryGradient = LinearGradient(
  colors: [kPrimaryColor, kPrimaryLightColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kDrawerGradient = LinearGradient(
  colors: [kPrimaryColor, kPrimaryDarkColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

/// Common spacing values used to maintain consistent layouts.
const kPaddingSmall = 8.0;
const kPaddingMedium = 12.0;
const kPaddingLarge = 16.0;
const kPaddingXLarge = 20.0;

/// Common border radius values for reusable UI components.
const kRadiusSmall = 8.0;
const kRadiusMedium = 12.0;
const kRadiusLarge = 16.0;

/// Default height value for application buttons.
const kButtonHeight = 50.0;