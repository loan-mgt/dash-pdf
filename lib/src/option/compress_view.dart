import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/compressor.dart';


class CompressView extends StatefulWidget {
  const CompressView({super.key});

  @override
  _CompressViewState createState() => _CompressViewState();
}




class _CompressViewState extends State<CompressView> {
  String? selectedFileName;
  String? selectedFilePath;
  CompressionLevel selectedCompressionLevel = CompressionLevel.recommended;
  bool isCompressing = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: selectedFileName != null ? 400 : 120,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                'Compress PDF',
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  fontSize: theme.textTheme.headlineMedium?.fontSize,
                ),
              ),
              const SizedBox(height: 16),
              selectedFileName != null
                  ? Column(
                      children: [
                        Text(
                          'Selected File: $selectedFileName',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
                  : Container(),
              selectedFileName == null
                  ? FilledButton.icon(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );
                        if (result != null) {
                          String? filePath = result.files.single.path;
                          if (filePath != null) {
                            setState(() {
                              selectedFileName = filePath.split('/').last;
                              selectedFilePath = filePath;
                            });
                          }
                        }
                      },
                      icon: const Icon(Icons.file_upload),
                      label: const Text('Select File'),
                    )
                  : Container(),
              selectedFileName != null
                  ? Column(
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          'Compression Options',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                            fontSize: theme.textTheme.headlineSmall?.fontSize,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SegmentedButton(
                                  multiSelectionEnabled: false,
                                  emptySelectionAllowed: false,
                                  segments: [
                                    ButtonSegment(
                                        value: CompressionLevel.light,
                                        label: Text('Light'),
                                        icon: const Icon(null)),
                                    ButtonSegment(
                                        value: CompressionLevel.recommended,
                                        label: Text('Recommended'),
                                        icon: const Icon(null)),
                                    ButtonSegment(
                                        value: CompressionLevel.aggressive,
                                        label: Text('Agressive'),
                                        icon: const Icon(null)),
                                  ],
                                  selected: <CompressionLevel>{
                                    selectedCompressionLevel
                                  },
                                  onSelectionChanged:
                                      (Set<CompressionLevel> values) {
                                    setState(() {
                                      selectedCompressionLevel = values.first;
                                    });
                                  })
                            ]),
                        const SizedBox(height: 32),
                        FilledButton.icon(
                            onPressed: () async {
                              setState(() {
                                isCompressing = true;
                              });
                              // Perform compression
                              PdfCompressor.compressPdfFile(
                                selectedFilePath!,
                                '$selectedFileName-${selectedCompressionLevel.name}.pdf',
                                selectedCompressionLevel,
                              );
                              // Compression finished
                              setState(() {
                                isCompressing = false;
                              });
                              // Handle the compressed PDF path
                              Fluttertoast.showToast(
                                msg:
                                    'Compressed PDF saved at: $selectedFileName-${selectedCompressionLevel.name}.pdf',

                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: theme.colorScheme.tertiary ,
                                textColor: Colors.white,
                              );
                            },
                          icon: Icon(Icons.rocket_launch),
                          label: Text('GO !'),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
