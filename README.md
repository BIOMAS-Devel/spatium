# Spatium

Spatium is a Flutter package that provides a Bootstrap-inspired responsive grid
and responsive design tokens for typography, spacing and shared component
dimensions.

Its public API intentionally uses short, generic names such as `Container`,
`Row`, `Cell`, `Alignment`, `Size`, `ThemeData` and `TextStyle`. Because some
of these names overlap with Flutter classes, the recommended usage pattern is
to import Spatium with an alias.

## Recommended Import Style

```dart
import 'package:flutter/material.dart';
import 'package:spatium/spatium.dart' as spatium;
```

This lets you write Flutter widgets and Spatium layout primitives side by side
without ambiguity:

```dart
spatium.Container.limited(...)
spatium.Row(...)
spatium.Cell(...)
```

## Features

- 12-column responsive layout system
- Bootstrap-like breakpoints: `xs`, `sm`, `md`, `lg`, `xl`
- fluid and fixed-width containers
- responsive typography tokens
- responsive spacing tokens
- responsive component sizing tokens
- debug widget for active breakpoint inspection

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  spatium: ^0.1.0
```

If you still rely on the legacy static `TextStyle` helpers, initialize `Sizer`
at the application root. The newer responsive theme utilities work
independently, but `Sizer` is still used by the legacy static text presets.

## Core Concepts

### Layout primitives

- `spatium.Container` wraps a responsive page or section
- `spatium.Row` arranges cells inside a 12-column grid
- `spatium.Cell` renders a widget and defines its responsive column span

### Breakpoints

Use `spatium.Size` values to configure spans and visibility:

```dart
spatium.Size.xs
spatium.Size.md
spatium.Size.lg
```

### Theme tokens

Use `spatium.ThemeData` to define responsive values for:

- text sizes
- spacing
- shared component dimensions

## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:spatium/spatium.dart' as spatium;

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return spatium.Container.limited(
      sizeLimit: spatium.ContainerLimit.lg,
      rows: [
        spatium.Row(
          children: [
            spatium.Cell(
              columnSpan: const {
                spatium.Size.xs: 12,
                spatium.Size.md: 8,
              },
              builder: (context) => const Text('Main content'),
            ),
            spatium.Cell(
              columnSpan: const {
                spatium.Size.xs: 12,
                spatium.Size.md: 4,
              },
              builder: (context) => const Text('Sidebar'),
            ),
          ],
        ),
      ],
    );
  }
}
```

## Responsive Theme Setup

Register the default Spatium theme extension in Flutter's `ThemeData`:

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    extensions: const [
      spatium.ThemeData.bootstrap(),
    ],
  ),
  home: const DemoPage(),
)
```

Then read resolved values from the current `BuildContext`:

```dart
class DemoCard extends StatelessWidget {
  const DemoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.spatiumComponents.cardPadding),
      child: Text(
        'Responsive text',
        style: context.spatiumText.h4,
      ),
    );
  }
}
```

Available context helpers:

- `context.spatiumTheme`
- `context.spatiumText`
- `context.spatiumSpacing`
- `context.spatiumComponents`

## Custom Responsive Tokens

You can override the default Bootstrap-like tokens by supplying your own
`spatium.ThemeData`:

```dart
ThemeData(
  extensions: const [
    spatium.ThemeData(
      text: spatium.ResponsiveTextTheme(
        h1: spatium.ResponsiveValue(xs: 30, md: 36, lg: 44),
        h2: spatium.ResponsiveValue(xs: 24, md: 30, lg: 36),
        h3: spatium.ResponsiveValue(xs: 20, md: 24, lg: 30),
        h4: spatium.ResponsiveValue(xs: 18, md: 20, lg: 24),
        h5: spatium.ResponsiveValue(xs: 16, md: 18, lg: 20),
        h6: spatium.ResponsiveValue(xs: 14, md: 16, lg: 18),
        p: spatium.ResponsiveValue(xs: 14, md: 15, lg: 16),
      ),
      spacing: spatium.ResponsiveSpacing.bootstrap(),
      components: spatium.ResponsiveComponents.bootstrap(),
    ),
  ],
)
```

## Debugging Breakpoints

Place `spatium.Info` inside a `spatium.Container` to display the resolved width
and active breakpoint in debug mode:

```dart
const spatium.Info()
```

This widget renders nothing in release mode.

## Example App

A complete runnable example is available in [example/lib/main.dart](example/lib/main.dart).

Run it with:

```bash
cd example
flutter pub get
flutter run
```

## Notes

- `spatium.TextStyle.h1` to `spatium.TextStyle.p` are still available as legacy
  static styles
- for new code, prefer `spatium.TextStyle.of(context)` or `context.spatiumText`
- `spatium.Container` automatically injects responsive info for its descendants
- importing the package with an alias is strongly recommended because names
  such as `Row`, `Container`, `Alignment`, `Size`, `ThemeData` and `TextStyle`
  also exist in Flutter
