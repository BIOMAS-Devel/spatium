import 'package:flutter/widgets.dart' as m;

import 'size.dart';

/// Describes a single responsive grid cell inside a [Row].
///
/// Create a cell by providing a [builder] that returns the widget to render.
/// Optionally use [columnSpan] to define how many of the 12 available columns
/// the cell should occupy for each breakpoint.
class Cell {
  final m.Widget Function(m.BuildContext) _builder;
  final Map<Size, int>? _columnSpanOnSize;

  /// Creates a grid cell with an optional responsive column span map.
  ///
  /// If [columnSpan] is omitted, the cell occupies the full row on every
  /// breakpoint.
  Cell({
    required m.Widget Function(m.BuildContext) builder,
    Map<Size, int>? columnSpan,
  }) : _builder = builder,
       _columnSpanOnSize = columnSpan ?? <Size, int>{Size.xs: 12};

  /// Returns the widget builder used to render the cell content.
  m.Widget Function(m.BuildContext) get builder {
    return _builder;
  }

  /// Returns the configured column span map for each supported breakpoint.
  ///
  /// Missing breakpoints fall back to the nearest smaller declared size.
  Map<Size, int>? get columnSpanOnSize {
    return _columnSpanOnSize;
  }
}
