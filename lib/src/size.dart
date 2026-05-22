/// Represents the supported responsive breakpoints used by Spatium.
///
/// Use these values when defining responsive spans, visibility rules or custom
/// responsive tokens.
enum Size { xs, sm, md, lg, xl }

/// Represents the maximum container width preset for [Container.limited].
///
/// The selected value maps to Bootstrap-like fixed container widths from `sm`
/// to `xl`.
enum ContainerLimit { sm, md, lg, xl }

/// Lists all supported breakpoints from smallest to largest.
const sizes = <Size>[Size.xs, Size.sm, Size.md, Size.lg, Size.xl];

/// Lists all supported breakpoints from largest to smallest.
final reversedSizes = sizes.reversed;

/// Adds comparison operators to [Size] to simplify breakpoint checks.
extension SizeComparisonOperators on Size {
  /// Returns `true` when this breakpoint is smaller than [other].
  bool operator <(Size other) {
    return index < other.index;
  }

  /// Returns `true` when this breakpoint is smaller than or equal to [other].
  bool operator <=(Size other) {
    return index <= other.index;
  }

  /// Returns `true` when this breakpoint is larger than [other].
  bool operator >(Size other) {
    return index > other.index;
  }

  /// Returns `true` when this breakpoint is larger than or equal to [other].
  bool operator >=(Size other) {
    return index >= other.index;
  }
}
