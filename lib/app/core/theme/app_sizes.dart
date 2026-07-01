import 'package:flutter/material.dart';

class AppSizes {
  // --- Core Numeric Constants ---
  static const double x2 = 2.0;
  static const double x4 = 4.0;
  static const double x6 = 6.0;
  static const double x8 = 8.0;
  static const double x10 = 10.0;
  static const double x12 = 12.0;
  static const double x14 = 14.0;
  static const double x16 = 16.0;
  static const double x18 = 18.0;
  static const double x20 = 20.0; // Intermediate size
  static const double x24 = 24.0;
  static const double x28 = 28.0;
  static const double x32 = 32.0;
  static const double x40 = 40.0;
  static const double x48 = 48.0;
  static const double x64 = 64.0;

  // --- Constant Gap Widgets (SizedBox) ---
  // Using these prevents "Magic Numbers" in your Column/Row children

  // Vertical Gaps
  static const gapH4 = SizedBox(height: x4);
  static const gapH8 = SizedBox(height: x8);
  static const gapH12 = SizedBox(height: x12);
  static const gapH16 = SizedBox(height: x16);
  static const gapH20 = SizedBox(height: x20);
  static const gapH24 = SizedBox(height: x24);
  static const gapH32 = SizedBox(height: x32);

  // Horizontal Gaps
  static const gapW4 = SizedBox(width: x4);
  static const gapW8 = SizedBox(width: x8);
  static const gapW12 = SizedBox(width: x12);
  static const gapW16 = SizedBox(width: x16);
  static const gapW20 = SizedBox(width: x20);
  static const gapW24 = SizedBox(width: x24);
  static const gapW32 = SizedBox(width: x32);

  // --- Common Edge Insets (Padding/Margins) ---
  static const p4 = EdgeInsets.all(x4);
  static const p8 = EdgeInsets.all(x8);
  static const p12 = EdgeInsets.all(x12);
  static const p16 = EdgeInsets.all(x16);
  static const p20 = EdgeInsets.all(x20);
  static const p24 = EdgeInsets.all(x24);
}
