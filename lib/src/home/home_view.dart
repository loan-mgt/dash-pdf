import 'package:dash_pdf/src/service/dynamic_assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final pathCompress = DynamicAssetsPath(
      fileName: 'compress.png',
      brightness: theme.brightness,
      isUniqueFile: false,
    );

    final pathMerge = DynamicAssetsPath(
      fileName: 'merge.png',
      brightness: theme.brightness,
      isUniqueFile: true,
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 20), // Add some space between header and cards
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20.0, // Adjust the spacing between cards as needed
                  children: [
                    OptionCard(
                      illustrationPath: pathMerge.path,
                      illustrationAlt: 'Merge PDF',
                    ),
                    OptionCard(
                      illustrationPath: pathCompress.path,
                      illustrationAlt: 'Compress PDF',
                    ),
                    // Add more OptionCard widgets as needed
                  ],
                ),
              ),
              // Other widgets can be added here
            ],
          ),
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String illustrationPath;
  final String illustrationAlt;

  const OptionCard({
    super.key,
    required this.illustrationPath,
    required this.illustrationAlt,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card.outlined(
      color: theme.colorScheme.surface,
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CardIllustration(
              path: illustrationPath,
              alt: illustrationAlt,
            ),
            const SizedBox(height: 16),
            Text(
              illustrationAlt,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: theme.textTheme.titleLarge?.fontSize,
              ),
            )

            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}

class CardIllustration extends StatelessWidget {
  final String path;
  final String alt;

  const CardIllustration({
    super.key,
    required this.path,
    required this.alt,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.fitHeight,
      width: 300,
      height: 120,
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  static const fileName = 'header.svg';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final path = DynamicAssetsPath(
      fileName: fileName,
      brightness: theme.brightness,
      isUniqueFile: false,
    );

    return SvgPicture.asset(
      path.path, // Use path.path instead of a hardcoded string
      height: 200,
      width: 200,
      semanticsLabel: 'Dash PDF Logo',
    );
  }
}
