import 'package:flutter/material.dart' as m;

import 'responsive_value.dart';

@m.immutable
/// Collects all responsive design tokens used by Spatium widgets.
///
/// Add this class to `ThemeData.extensions` to override the default Bootstrap-
/// like token set for text, spacing and component dimensions.
class ThemeData extends m.ThemeExtension<ThemeData> {
  /// Creates a theme from custom responsive token groups.
  const ThemeData({
    required this.text,
    required this.spacing,
    required this.components,
  });

  /// Creates the default Bootstrap-inspired responsive token set.
  const ThemeData.bootstrap()
    : text = const ResponsiveTextTheme.bootstrap(),
      spacing = const ResponsiveSpacing.bootstrap(),
      components = const ResponsiveComponents.bootstrap();

  /// Responsive text tokens.
  final ResponsiveTextTheme text;

  /// Responsive spacing tokens.
  final ResponsiveSpacing spacing;

  /// Responsive component sizing tokens.
  final ResponsiveComponents components;

  @override
  /// Returns a copy of the theme with selectively replaced token groups.
  ThemeData copyWith({
    ResponsiveTextTheme? text,
    ResponsiveSpacing? spacing,
    ResponsiveComponents? components,
  }) {
    return ThemeData(
      text: text ?? this.text,
      spacing: spacing ?? this.spacing,
      components: components ?? this.components,
    );
  }

  @override
  /// Interpolates between two theme instances.
  ThemeData lerp(covariant m.ThemeExtension<ThemeData>? other, double t) {
    if (other is! ThemeData) {
      return this;
    }

    return t < 0.5 ? this : other;
  }
}

@m.immutable
/// Defines the responsive typography scale used by Spatium.
class ResponsiveTextTheme {
  /// Creates a custom responsive text token set.
  const ResponsiveTextTheme({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.p,
  });

  /// Creates the default Bootstrap-inspired responsive text scale.
  const ResponsiveTextTheme.bootstrap()
    : h1 = const ResponsiveValue<double>(xs: 28, md: 34, lg: 40),
      h2 = const ResponsiveValue<double>(xs: 24, md: 30, lg: 34),
      h3 = const ResponsiveValue<double>(xs: 20, md: 24, lg: 28),
      h4 = const ResponsiveValue<double>(xs: 18, md: 20, lg: 24),
      h5 = const ResponsiveValue<double>(xs: 16, md: 18, lg: 20),
      h6 = const ResponsiveValue<double>(xs: 15, md: 16, lg: 18),
      p = const ResponsiveValue<double>(xs: 14, md: 15, lg: 16);

  final ResponsiveValue<double> h1;
  final ResponsiveValue<double> h2;
  final ResponsiveValue<double> h3;
  final ResponsiveValue<double> h4;
  final ResponsiveValue<double> h5;
  final ResponsiveValue<double> h6;
  final ResponsiveValue<double> p;
}

@m.immutable
/// Defines the responsive spacing scale used throughout the package.
class ResponsiveSpacing {
  /// Creates a custom responsive spacing scale.
  const ResponsiveSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  /// Creates the default Bootstrap-inspired spacing scale.
  const ResponsiveSpacing.bootstrap()
    : xs = const ResponsiveValue<double>(xs: 4, md: 6, lg: 8),
      sm = const ResponsiveValue<double>(xs: 8, md: 10, lg: 12),
      md = const ResponsiveValue<double>(xs: 12, md: 16, lg: 20),
      lg = const ResponsiveValue<double>(xs: 16, md: 24, lg: 32),
      xl = const ResponsiveValue<double>(xs: 24, md: 32, lg: 48);

  final ResponsiveValue<double> xs;
  final ResponsiveValue<double> sm;
  final ResponsiveValue<double> md;
  final ResponsiveValue<double> lg;
  final ResponsiveValue<double> xl;
}

@m.immutable
/// Defines responsive sizing tokens for shared component chrome.
class ResponsiveComponents {
  /// Creates a custom component token set.
  const ResponsiveComponents({
    required this.containerPadding,
    required this.cellPadding,
    required this.cardPadding,
    required this.cardRadius,
    required this.chipSpacing,
  });

  /// Creates the default Bootstrap-inspired component token set.
  const ResponsiveComponents.bootstrap()
    : containerPadding = const ResponsiveValue<double>(xs: 12, md: 16, lg: 24),
      cellPadding = const ResponsiveValue<double>(xs: 6, md: 8, lg: 10),
      cardPadding = const ResponsiveValue<double>(xs: 16, md: 20, lg: 24),
      cardRadius = const ResponsiveValue<double>(xs: 16, md: 20, lg: 24),
      chipSpacing = const ResponsiveValue<double>(xs: 8, md: 10, lg: 12);

  final ResponsiveValue<double> containerPadding;
  final ResponsiveValue<double> cellPadding;
  final ResponsiveValue<double> cardPadding;
  final ResponsiveValue<double> cardRadius;
  final ResponsiveValue<double> chipSpacing;
}

/// Resolves [ResponsiveTextTheme] into concrete [m.TextStyle] objects.
class ResolvedTextTheme {
  ResolvedTextTheme._(this._context, this._theme);

  final m.BuildContext _context;
  final ThemeData _theme;

  m.TextStyle get h1 => _headline(_theme.text.h1.resolve(_context));
  m.TextStyle get h2 => _headline(_theme.text.h2.resolve(_context));
  m.TextStyle get h3 => _headline(_theme.text.h3.resolve(_context));
  m.TextStyle get h4 => _headline(_theme.text.h4.resolve(_context));
  m.TextStyle get h5 => _headline(_theme.text.h5.resolve(_context));
  m.TextStyle get h6 => _headline(_theme.text.h6.resolve(_context));
  m.TextStyle get p => m.TextStyle(fontSize: _theme.text.p.resolve(_context));

  m.TextStyle _headline(double size) {
    return m.TextStyle(fontSize: size, fontWeight: m.FontWeight.bold);
  }
}

/// Resolves [ResponsiveSpacing] into concrete spacing values.
class ResolvedSpacing {
  ResolvedSpacing._(this._context, this._theme);

  final m.BuildContext _context;
  final ThemeData _theme;

  double get xs => _theme.spacing.xs.resolve(_context);
  double get sm => _theme.spacing.sm.resolve(_context);
  double get md => _theme.spacing.md.resolve(_context);
  double get lg => _theme.spacing.lg.resolve(_context);
  double get xl => _theme.spacing.xl.resolve(_context);
}

/// Resolves [ResponsiveComponents] into concrete component dimensions.
class ResolvedComponents {
  ResolvedComponents._(this._context, this._theme);

  final m.BuildContext _context;
  final ThemeData _theme;

  double get containerPadding =>
      _theme.components.containerPadding.resolve(_context);
  double get cellPadding => _theme.components.cellPadding.resolve(_context);
  double get cardPadding => _theme.components.cardPadding.resolve(_context);
  double get cardRadius => _theme.components.cardRadius.resolve(_context);
  double get chipSpacing => _theme.components.chipSpacing.resolve(_context);
}

/// Adds convenient accessors for Spatium responsive tokens to [m.BuildContext].
extension SpatiumContextExtension on m.BuildContext {
  /// Returns the nearest configured [ThemeData] or the default one.
  ThemeData get spatiumTheme =>
      m.Theme.of(this).extension<ThemeData>() ?? const ThemeData.bootstrap();

  /// Returns resolved responsive text styles for the current breakpoint.
  ResolvedTextTheme get spatiumText => ResolvedTextTheme._(this, spatiumTheme);

  /// Returns resolved spacing tokens for the current breakpoint.
  ResolvedSpacing get spatiumSpacing => ResolvedSpacing._(this, spatiumTheme);

  /// Returns resolved component sizing tokens for the current breakpoint.
  ResolvedComponents get spatiumComponents =>
      ResolvedComponents._(this, spatiumTheme);
}
