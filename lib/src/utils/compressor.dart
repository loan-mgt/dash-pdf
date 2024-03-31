import 'package:flutter/services.dart';

enum CompressionLevel { light , recommended, aggressive }


extension CompressionValue on CompressionLevel {
  int get compressionValue {
    switch (this) {
      case CompressionLevel.light:
        return 50; // Adjust as needed
      case CompressionLevel.recommended:
        return 75; // Adjust as needed
      case CompressionLevel.aggressive:
        return 90; // Adjust as needed
    }
  }
}


class PdfCompressor {
  static const MethodChannel _channel =
  MethodChannel('pdf_compressor');

  static Future<void> compressPdfFile(
      String inputPath, String outputPath, CompressionLevel quality) async {
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent("inputPath", () => inputPath);
    args.putIfAbsent("outputPath", () => outputPath);
    args.putIfAbsent("quality", () => quality.index); // assuming quality is an enum

    return await _channel.invokeMethod('compressPdf', args);
  }
}
