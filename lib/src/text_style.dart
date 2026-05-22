import 'package:flutter/material.dart' as m;
import 'package:sizer/sizer.dart';

import 'theme.dart';

/// Provides text styles for Spatium widgets.
///
/// The static fields expose the legacy fixed styles, while [of] resolves the
/// responsive text theme configured in [ThemeData].
class TextStyle {
  static final int _baseFontSize = 15;

  /// Legacy heading level 1 style based on `Sizer`.
  static final h1 = m.TextStyle(
    fontSize: (_baseFontSize + 6).sp,
    fontWeight: m.FontWeight.bold,
  );

  /// Legacy heading level 2 style based on `Sizer`.
  static final h2 = m.TextStyle(
    fontSize: (_baseFontSize + 5).sp,
    fontWeight: m.FontWeight.bold,
  );

  /// Legacy heading level 3 style based on `Sizer`.
  static final h3 = m.TextStyle(
    fontSize: (_baseFontSize + 4).sp,
    fontWeight: m.FontWeight.bold,
  );

  /// Legacy heading level 4 style based on `Sizer`.
  static final h4 = m.TextStyle(
    fontSize: (_baseFontSize + 3).sp,
    fontWeight: m.FontWeight.bold,
  );

  /// Legacy heading level 5 style based on `Sizer`.
  static final h5 = m.TextStyle(
    fontSize: (_baseFontSize + 2).sp,
    fontWeight: m.FontWeight.bold,
  );

  /// Legacy heading level 6 style based on `Sizer`.
  static final h6 = m.TextStyle(
    fontSize: _baseFontSize.sp,
    fontWeight: m.FontWeight.bold,
  );

  /// Legacy paragraph style based on `Sizer`.
  static final p = m.TextStyle(fontSize: _baseFontSize.sp);

  /// Returns the responsive text styles resolved for the current breakpoint.
  static ResolvedTextTheme of(m.BuildContext context) {
    return context.spatiumText;
  }
}
