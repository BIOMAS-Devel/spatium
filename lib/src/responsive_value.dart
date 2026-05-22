import 'package:flutter/widgets.dart' as m;

import 'size.dart';
import 'size_detector.dart';

@m.immutable
/// Stores a value that can vary across Spatium breakpoints.
///
/// Use this class for responsive tokens such as font sizes, spacing or radii.
/// When a breakpoint-specific value is missing, the nearest smaller declared
/// breakpoint is used as a fallback.
class ResponsiveValue<T> {
  /// Creates a responsive value map with `xs` as the required base value.
  const ResponsiveValue({required this.xs, this.sm, this.md, this.lg, this.xl});

  final T xs;
  final T? sm;
  final T? md;
  final T? lg;
  final T? xl;

  /// Resolves the most appropriate value for a specific [Size].
  T resolveForSize(Size size) {
    switch (size) {
      case Size.xl:
        return xl ?? lg ?? md ?? sm ?? xs;
      case Size.lg:
        return lg ?? md ?? sm ?? xs;
      case Size.md:
        return md ?? sm ?? xs;
      case Size.sm:
        return sm ?? xs;
      case Size.xs:
        return xs;
    }
  }

  /// Resolves the value using the current screen breakpoint from [context].
  T resolve(m.BuildContext context) {
    final size = SizeDetector.absolute(context: context).size;
    return resolveForSize(size);
  }
}
