import 'package:flutter/widgets.dart' as m;

import 'size.dart';

/// Propagates resolved responsive information to descendants.
///
/// This widget is inserted by [Container] and is mainly consumed by helper
/// widgets such as [Info]. External code usually reads it with [of]
/// instead of creating it directly.
class InfoProvider extends m.InheritedWidget {
  /// The current responsive information exposed to descendants.
  final InfoData data;

  /// Creates a provider that exposes [data] to its widget subtree.
  const InfoProvider({super.key, required super.child, required this.data});

  /// Reads the nearest [InfoData] from the widget tree.
  ///
  /// Call this only below an [InfoProvider], which is usually provided
  /// automatically by [Container].
  static InfoData of(m.BuildContext context) {
    final InfoProvider? result =
        context.dependOnInheritedWidgetOfExactType<InfoProvider>();
    assert(result != null, 'No InfoProvider found in context');
    return result!.data;
  }

  @override
  /// Notifies dependents when size-related information changes.
  bool updateShouldNotify(InfoProvider oldWidget) {
    return oldWidget.data.size != data.size ||
        oldWidget.data.width != data.width;
  }
}

/// Holds the responsive information computed by a [Container].
///
/// Use this object to inspect the active breakpoint, resolved width and whether
/// the layout was measured against the whole screen or only the parent box.
class InfoData {
  /// Whether breakpoint resolution used the screen width instead of constraints.
  final bool absolute;

  /// The active responsive size.
  final Size size;

  /// The width used to resolve [size].
  final double width;

  /// Creates a responsive info snapshot for descendants.
  InfoData({required this.absolute, required this.size, required this.width});
}
