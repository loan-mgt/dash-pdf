import 'dart:ui';

class DynamicAssetsPath {
  final bool isUniqueFile;
  final String rootPath = 'assets/images';
  final String darkPath = '/dark';
  final String fileName;
  final Brightness brightness;

  const DynamicAssetsPath({
    required this.fileName,
    required this.brightness,
    required this.isUniqueFile,
  });

  String get darkFullPath => '$rootPath$darkPath/$fileName';

  String get lightFullPath => '$rootPath/$fileName';

  String get path {
    // Define asset paths for both light and dark themes
    String assetPath = brightness == Brightness.dark
        ? (isUniqueFile ? lightFullPath : darkFullPath)
        : lightFullPath;

    return assetPath;
  }
}
