import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spatium/spatium.dart' as spatium;

/// Bootstraps the demo application used to showcase Spatium.
void main() {
  runApp(const ExampleApp());
}

/// Root widget of the example application.
class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Spatium Example',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            scaffoldBackgroundColor: const Color(0xFFF3F6F8),
            useMaterial3: true,
            extensions: const [spatium.ThemeData.bootstrap()],
          ),
          home: const ExampleHomePage(),
        );
      },
    );
  }
}

/// Demonstrates how to compose a responsive page with Spatium using a package
/// alias to avoid conflicts with Flutter classes.
class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spatium responsive grid')),
      body: SingleChildScrollView(
        child: Center(
          child: spatium.Container.limited(
            sizeLimit: spatium.ContainerLimit.lg,
            rows: [
              spatium.Row(
                children: [
                  spatium.Cell(
                    columnSpan: const {spatium.Size.xs: 12, spatium.Size.md: 8},
                    builder:
                        (context) => _SectionCard(
                          title: 'Hero',
                          description:
                              'This block spans the full width on mobile and 8 columns from tablet upward.',
                          color: const Color(0xFF0F766E),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Build responsive interfaces with a 12-column grid.',
                                style: context.spatiumText.h3.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: context.spatiumSpacing.sm),
                              Text(
                                'Resize the window to see how cell spans, spacing and text scale change.',
                                style: context.spatiumText.p.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                  ),
                  spatium.Cell(
                    columnSpan: const {spatium.Size.xs: 12, spatium.Size.md: 4},
                    builder:
                        (context) => _SectionCard(
                          title: 'Debug info',
                          description:
                              'Info displays the active breakpoint and resolved width in debug mode.',
                          color: Colors.white,
                          child: const spatium.Info(),
                        ),
                  ),
                ],
              ),
              spatium.Row(
                children: [
                  spatium.Cell(
                    columnSpan: const {
                      spatium.Size.xs: 12,
                      spatium.Size.sm: 6,
                      spatium.Size.lg: 3,
                    },
                    builder:
                        (context) =>
                            const _FeatureTile(title: 'XS', text: '12 columns'),
                  ),
                  spatium.Cell(
                    columnSpan: const {
                      spatium.Size.xs: 12,
                      spatium.Size.sm: 6,
                      spatium.Size.lg: 3,
                    },
                    builder:
                        (context) => const _FeatureTile(
                          title: 'SM',
                          text: '2 cards per row',
                        ),
                  ),
                  spatium.Cell(
                    columnSpan: const {
                      spatium.Size.xs: 12,
                      spatium.Size.sm: 6,
                      spatium.Size.lg: 3,
                    },
                    builder:
                        (context) => const _FeatureTile(
                          title: 'LG',
                          text: '4 cards per row',
                        ),
                  ),
                  spatium.Cell(
                    columnSpan: const {
                      spatium.Size.xs: 12,
                      spatium.Size.sm: 6,
                      spatium.Size.lg: 3,
                    },
                    builder:
                        (context) => const _FeatureTile(
                          title: 'Theme',
                          text: 'Responsive padding and typography',
                        ),
                  ),
                ],
              ),
              spatium.Row(
                children: [
                  spatium.Cell(
                    columnSpan: const {spatium.Size.xs: 12, spatium.Size.md: 6},
                    builder:
                        (context) => _SectionCard(
                          title: 'Sidebar',
                          description:
                              'Secondary content falls below the main section on small screens.',
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _BulletLine('Side navigation'),
                              _BulletLine('Filters'),
                              _BulletLine('Supporting content'),
                            ],
                          ),
                        ),
                  ),
                  spatium.Cell(
                    columnSpan: const {spatium.Size.xs: 12, spatium.Size.md: 6},
                    builder:
                        (context) => _SectionCard(
                          title: 'Content',
                          description:
                              'Cells can render any Flutter widget through the provided builder.',
                          color: Colors.white,
                          child: Wrap(
                            spacing: context.spatiumComponents.chipSpacing,
                            runSpacing: context.spatiumComponents.chipSpacing,
                            children: List.generate(
                              6,
                              (index) => Chip(label: Text('Item ${index + 1}')),
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.description,
    required this.color,
    required this.child,
  });

  final String title;
  final String description;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final onColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
            ? Colors.white
            : const Color(0xFF0F172A);
    final cardPadding = context.spatiumComponents.cardPadding;
    final cardRadius = context.spatiumComponents.cardRadius;
    final spacing = context.spatiumSpacing;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.spatiumText.h4.copyWith(color: onColor)),
            SizedBox(height: spacing.xs),
            Text(
              description,
              style: context.spatiumText.p.copyWith(
                color: onColor.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: spacing.md),
            DefaultTextStyle(
              style: context.spatiumText.p.copyWith(color: onColor),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.spatiumComponents.cardPadding;
    final cardRadius = context.spatiumComponents.cardRadius;
    final spacing = context.spatiumSpacing;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.spatiumText.h5),
            SizedBox(height: spacing.xs),
            Text(text, style: context.spatiumText.p),
          ],
        ),
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spatiumSpacing;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.xs),
      child: Row(
        children: [
          Container(
            width: spacing.xs,
            height: spacing.xs,
            decoration: const BoxDecoration(
              color: Color(0xFF0F766E),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spacing.sm),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
