import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFDADA),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Adjust the padding as needed
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              SizedBox(height: 20), // Add some space between header and cards
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20.0, // Adjust the spacing between cards as needed
                  children: [
                    OptionCard(
                      illustrationPath: 'assets/images/merge.svg',
                      illustrationAlt: 'Merge PDF',
                    ),
                    OptionCard(
                      illustrationPath: 'assets/images/compress.svg',
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
    return Card(
      borderOnForeground: true,
      child: Column(
        children: [
          CardIllustration(
            path: illustrationPath,
            alt: illustrationAlt,
          ),
          // Add more widgets as needed
        ],
      ),
    );
  }
}

class CardIllustration extends StatelessWidget {
  final String path;
  final String alt;

  const CardIllustration({
    Key? key,
    required this.path,
    required this.alt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: 200,
      width: 200,
      semanticsLabel: alt,
    );
  }
}


class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/header.svg',
      height: 200,
      width: 200,
      semanticsLabel: 'Dash PDF Logo',
    );
  }
}