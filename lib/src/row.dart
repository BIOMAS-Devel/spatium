import 'package:flutter/widgets.dart' as m;

import 'alignment.dart';
import 'cell.dart';
import 'constants.dart';
import 'size.dart';

/// Groups multiple [Cell] items into a responsive row.
///
/// A row distributes its cells across a 12-column grid and automatically wraps
/// them into additional visual rows when their combined span exceeds the
/// available width for the current breakpoint.
class Row {
  final List<Cell> _cells;
  final List<Size> _visibleOnSizes;
  final Alignment _mainAxisAlignment;
  final Alignment _crossAxisAlignment;

  /// Creates a responsive row.
  ///
  /// Use [children] to provide the cells to render. Use [visibleOnSizes] to
  /// limit the row visibility to specific breakpoints. Alignment values control
  /// how remaining horizontal space and vertical alignment are handled.
  Row({
    required List<Cell> children,
    List<Size>? visibleOnSizes,
    Alignment? mainAxisAlignment,
    Alignment? crossAxisAlignment,
    bool? expanded,
  }) : _cells = children,
       _visibleOnSizes = visibleOnSizes ?? sizes,
       _mainAxisAlignment = mainAxisAlignment ?? Alignment.start,
       _crossAxisAlignment = crossAxisAlignment ?? Alignment.start;

  /// Builds the Flutter [m.Widget] rows needed to render this responsive row.
  ///
  /// This method is primarily used internally by [Container]. External callers
  /// normally create [Row] instances and let the container render them
  /// automatically.
  List<m.Widget> createRowWidgets(
    m.BuildContext context,
    Size size,
    m.EdgeInsets cellEdgeInsets,
  ) {
    if (!_visibleOnSizes.contains(size)) {
      return [];
    }

    final innerRows = _splitCellsIntoInnerRows(size);
    final rowWidgets = <m.Widget>[];

    for (var innerRow in innerRows) {
      var innerRowTotalColumnSpan = 0;
      for (var cell in innerRow) {
        innerRowTotalColumnSpan += _getCellColumnSpanOnSize(cell, size);
      }
      final remainingSpan = maxCellsPerRow - innerRowTotalColumnSpan;
      final innerRowWidgets = <m.Widget>[];

      if (_mainAxisAlignment == Alignment.end && remainingSpan > 0) {
        innerRowWidgets.add(
          m.Expanded(flex: remainingSpan, child: m.Container()),
        );
      }
      if (_mainAxisAlignment == Alignment.center && remainingSpan > 0) {
        final leadingSpan = (remainingSpan / 2).floor();
        if (leadingSpan > 0) {
          innerRowWidgets.add(
            m.Expanded(flex: leadingSpan, child: m.Container()),
          );
        }
      }

      for (var cell in innerRow) {
        innerRowWidgets.add(
          _createCellWidget(context, cell, size, cellEdgeInsets),
        );
      }

      if (_mainAxisAlignment == Alignment.start && remainingSpan > 0) {
        innerRowWidgets.add(
          m.Expanded(flex: remainingSpan, child: m.Container()),
        );
      }
      if (_mainAxisAlignment == Alignment.center && remainingSpan > 0) {
        final trailingSpan = (remainingSpan / 2).ceil();
        if (trailingSpan > 0) {
          innerRowWidgets.add(
            m.Expanded(flex: trailingSpan, child: m.Container()),
          );
        }
      }

      if (innerRowWidgets.isNotEmpty) {
        final crossAxisAlignment =
            _crossAxisAlignment == Alignment.start
                ? m.CrossAxisAlignment.start
                : _crossAxisAlignment == Alignment.center
                ? m.CrossAxisAlignment.center
                : m.CrossAxisAlignment.end;
        rowWidgets.add(
          m.Row(
            mainAxisAlignment: m.MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: m.MainAxisSize.max,
            children: innerRowWidgets,
          ),
        );
      }
    }

    return rowWidgets;
  }

  List<List<Cell>> _splitCellsIntoInnerRows(Size size) {
    final result = <List<Cell>>[];
    var currentRow = <Cell>[];
    var currentSpan = 0;

    for (final cell in _cells) {
      final cellColumnSpan = _getCellColumnSpanOnSize(cell, size);
      if (currentSpan + cellColumnSpan > maxCellsPerRow) {
        result.add(currentRow);
        currentRow = [];
        currentSpan = 0;
      }

      currentRow.add(cell);
      currentSpan += cellColumnSpan;
    }

    if (currentRow.isNotEmpty) {
      result.add(currentRow);
    }

    return result;
  }

  m.Widget _createCellWidget(
    m.BuildContext context,
    Cell cell,
    Size size,
    m.EdgeInsets cellEdgeInsets,
  ) {
    return m.Expanded(
      flex: _getCellColumnSpanOnSize(cell, size),
      child: m.Padding(padding: cellEdgeInsets, child: cell.builder(context)),
    );
  }

  int _getCellColumnSpanOnSize(Cell cell, Size size) {
    for (var reverseSize in reversedSizes) {
      if (reverseSize > size) {
        continue;
      }

      if (cell.columnSpanOnSize != null &&
          cell.columnSpanOnSize!.containsKey(reverseSize)) {
        return cell.columnSpanOnSize![reverseSize]!;
      }
    }

    return maxCellsPerRow;
  }
}
