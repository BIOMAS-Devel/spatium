import 'package:flutter/widgets.dart' as m;

import 'size.dart';
import 'size_info.dart';

/// Resolves the active [Size] from either screen width or layout width.
///
/// Use [SizeDetector.absolute] when breakpoint selection should depend on
/// the whole screen and [SizeDetector.relative] when it should depend on
/// the current layout constraints.
class SizeDetector {
  final bool _absolute;
  final double _width;
  final Size _size;

  /// Creates a detector based on the current screen width.
  SizeDetector.absolute({required m.BuildContext context})
    : _absolute = true,
      _width = m.MediaQuery.sizeOf(context).width,
      _size = _getBreakpoint(m.MediaQuery.sizeOf(context).width);

  /// Creates a detector based on the current layout constraints.
  SizeDetector.relative({required m.BoxConstraints constraints})
    : _absolute = false,
      _width = constraints.maxWidth,
      _size = _getBreakpoint(constraints.maxWidth);

  static Size _getBreakpoint(double width) {
    for (var breakpointInfo in sizeInfos) {
      if (width >= breakpointInfo.minWidth &&
          width <= breakpointInfo.maxWidth) {
        return breakpointInfo.screenSize;
      }
    }

    throw 'No breakpoint matched width: $width';
  }

  /// Whether the breakpoint was resolved from the screen width.
  bool get absolute {
    return _absolute;
  }

  /// The width used to resolve the current breakpoint.
  double get width {
    return _width;
  }

  /// The breakpoint resolved from [width].
  Size get size {
    return _size;
  }
}
