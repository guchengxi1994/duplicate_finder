import 'package:duplicate_finder/src/rust/api/scanner_api.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final stream = scannerCompareResultsStream();
  final eStream = eventStream();

  @override
  void initState() {
    super.initState();
    stream.listen((event) {
      print(event.field0.length);
    });

    eStream.listen((event) {
      print(event.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                final String? directoryPath = await getDirectoryPath();
                if (directoryPath == null) {
                  // Operation was canceled by the user.
                  return;
                }

                scan(p: directoryPath);
              },
              child: const Text("Select folder"))
        ],
      ),
    );
  }
}
