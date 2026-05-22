import 'package:flutter/widgets.dart' as m;

import 'constants.dart';
import 'info_provider.dart';
import 'row.dart';
import 'size.dart';
import 'size_detector.dart';
import 'theme.dart';

/// A responsive container that displays its content according to the screen or
/// parent width.
///
/// Contains a list of [Row].
///
/// The content may be laid out absolutely (according to screen width,
/// default or [absolute] == true) or relatively to the container size
/// ([absolute] == false).
///
/// The container may be [fluid], meaning it will always occupy 100% of its
/// parent width, otherwise a [sizeLimit] can be specified to limit its width
/// when the parent is large enough.
class Container extends m.StatelessWidget {
  final bool _fluid;
  final bool _absolute;
  final ContainerLimit? _sizeLimit;
  final List<Row> _rows;
  final m.EdgeInsets _cellEdgeInsets;

  const Container._({
    required bool fluid,
    required bool absolute,
    ContainerLimit? sizeLimit,
    required List<Row> rows,
    m.EdgeInsets? cellEdgeInsets,
    super.key,
  }) : _fluid = fluid,
       _absolute = absolute,
       _sizeLimit = sizeLimit,
       _rows = rows,
       _cellEdgeInsets = cellEdgeInsets ?? m.EdgeInsets.zero;

  /// Creates a full-width responsive container.
  ///
  /// Use this constructor when the grid should always span the available width
  /// of its parent. Pass [absolute] as `false` to resolve breakpoints from the
  /// container constraints instead of the screen width.
  const Container.fluid({
    required List<Row> rows,
    bool? absolute,
    m.EdgeInsets? cellEdgeInsets,
    m.Key? key,
  }) : this._(
         rows: rows,
         fluid: true,
         absolute: absolute ?? true,
         sizeLimit: null,
         cellEdgeInsets: cellEdgeInsets,
         key: key,
       );

  /// Creates a responsive container with a maximum width tied to a breakpoint.
  ///
  /// Use [sizeLimit] to cap the container width similarly to Bootstrap's fixed
  /// containers. Below that breakpoint, the container still expands to the full
  /// available width.
  const Container.limited({
    required List<Row> rows,
    bool? absolute,
    required ContainerLimit sizeLimit,
    m.EdgeInsets? cellEdgeInsets,
    m.Key? key,
  }) : this._(
         fluid: false,
         absolute: absolute ?? true,
         sizeLimit: sizeLimit,
         cellEdgeInsets: cellEdgeInsets,
         rows: rows,
         key: key,
       );

  @override
  /// Builds the container and resolves the active responsive layout.
  m.Widget build(m.BuildContext context) {
    if (_rows.isEmpty) {
      return m.Container();
    }

    return m.LayoutBuilder(builder: _layoutBuilder);
  }

  m.Widget _layoutBuilder(
    m.BuildContext context,
    m.BoxConstraints constraints,
  ) {
    final containerSize =
        _absolute
            ? SizeDetector.absolute(context: context)
            : SizeDetector.relative(constraints: constraints);
    final sizeLimit = _sizeLimit == null ? null : _convertToSize(_sizeLimit);
    final ownSize =
        _fluid
            ? containerSize.size
            : containerSize.size > sizeLimit!
            ? sizeLimit
            : containerSize.size;

    final rowWidgets = _createRowsWidgets(context, ownSize);
    if (rowWidgets.isEmpty) {
      return m.Container();
    }

    return InfoProvider(
      data: InfoData(
        absolute: containerSize.absolute,
        size: ownSize,
        width: containerSize.width,
      ),
      child: _buildContainer(context, ownSize, rowWidgets),
    );
  }

  m.Widget _buildContainer(
    m.BuildContext context,
    Size ownSize,
    List<m.Widget> rowWidgets,
  ) {
    if (_fluid) {
      return _buildWholeWidthContainer(context, rowWidgets);
    }

    if (ownSize >= _convertToSize(_sizeLimit!)) {
      final containerWidth = _getContainerWidth(_convertToSize(_sizeLimit));
      return _buildWidthConstrainedContainer(
        context,
        rowWidgets,
        containerWidth,
      );
    }

    return _buildWholeWidthContainer(context, rowWidgets);
  }

  List<m.Widget> _createRowsWidgets(m.BuildContext context, Size size) {
    final resolvedCellEdgeInsets =
        _cellEdgeInsets == m.EdgeInsets.zero
            ? m.EdgeInsets.all(context.spatiumComponents.cellPadding)
            : _cellEdgeInsets;
    final rowsWidgets = <m.Widget>[];
    for (var row in _rows) {
      final rowWidgets = row.createRowWidgets(
        context,
        size,
        resolvedCellEdgeInsets,
      );
      if (rowWidgets.isNotEmpty) {
        rowsWidgets.addAll(rowWidgets);
      }
    }
    return rowsWidgets;
  }

  m.Widget _buildWholeWidthContainer(
    m.BuildContext context,
    List<m.Widget> children,
  ) {
    final padding = context.spatiumComponents.containerPadding;

    return m.Padding(
      padding: m.EdgeInsets.all(padding),
      child: m.Column(
        crossAxisAlignment: m.CrossAxisAlignment.start,
        mainAxisSize: m.MainAxisSize.min,
        children: children,
      ),
    );
  }

  m.Widget _buildWidthConstrainedContainer(
    m.BuildContext context,
    List<m.Widget> children,
    double containerWidth,
  ) {
    return m.ConstrainedBox(
      constraints: m.BoxConstraints(maxWidth: containerWidth),
      child: _buildWholeWidthContainer(context, children),
    );
  }

  Size _convertToSize(ContainerLimit sizeLimit) {
    switch (sizeLimit) {
      case ContainerLimit.sm:
        return Size.sm;
      case ContainerLimit.md:
        return Size.md;
      case ContainerLimit.lg:
        return Size.lg;
      case ContainerLimit.xl:
        return Size.xl;
    }
  }

  double _getContainerWidth(Size size) {
    switch (size) {
      case Size.xs:
        throw ArgumentError();
      case Size.sm:
      case Size.md:
      case Size.lg:
      case Size.xl:
        return containerWidths[size.index - 1];
    }
  }
}
