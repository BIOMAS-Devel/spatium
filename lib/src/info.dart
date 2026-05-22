import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' as m;

import 'info_provider.dart';

/// Displays the currently resolved Spatium breakpoint information.
///
/// This widget is intended as a debug helper. Place it inside a
/// [Container] to inspect whether width resolution is absolute or relative
/// and which [size] is currently active.
class Info extends m.StatelessWidget {
  /// Creates a debug widget that prints responsive info when assertions are on.
  const Info({super.key});

  @override
  /// Builds the debug label.
  ///
  /// In release mode this widget renders an empty container.
  m.Widget build(m.BuildContext context) {
    if (!kDebugMode) {
      return m.Container();
    }

    final infoData = InfoProvider.of(context);
    return m.Text(
      '${infoData.absolute ? "absolute" : "relative"} width: ${infoData.size} ${infoData.width}',
    );
  }
}
