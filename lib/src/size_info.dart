import 'constants.dart';
import 'size.dart';

/// Describes the width range associated with a specific [Size].
///
/// Instances of this class are used internally to map widths to breakpoints.
class ScreenSizeInfo {
  /// The breakpoint represented by this range.
  final Size screenSize;

  /// The minimum width, inclusive, for [screenSize].
  final double minWidth;

  /// The maximum width, inclusive, for [screenSize].
  final double maxWidth;

  /// Creates the width range metadata for a given [screenSize].
  ScreenSizeInfo({required this.screenSize})
    : minWidth = screenSize.index == 0 ? 0 : breakpoints[screenSize.index - 1],
      maxWidth =
          screenSize.index == breakpoints.length
              ? double.infinity
              : breakpoints[screenSize.index] - 1;
}

/// Declares the ordered width ranges used to resolve responsive breakpoints.
final sizeInfos = [
  ScreenSizeInfo(screenSize: Size.xs),
  ScreenSizeInfo(screenSize: Size.sm),
  ScreenSizeInfo(screenSize: Size.md),
  ScreenSizeInfo(screenSize: Size.lg),
  ScreenSizeInfo(screenSize: Size.xl),
];
