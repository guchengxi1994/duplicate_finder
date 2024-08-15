import 'package:duplicate_finder/app/logger.dart';
import 'package:duplicate_finder/src/rust/api/scanner_api.dart';
import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';
import 'package:file_selector/file_selector.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final stream = scannerCompareResultsStream();
  final eStream = eventStream();

  // ignore: avoid_init_to_null
  late CompareResults? compareResults = null;

  bool asc = false;

  @override
  void initState() {
    super.initState();
    stream.listen((event) {
      print(event.field0.length);

      setState(() {
        compareResults = event;
      });
    });

    eStream.listen((event) {
      // print(event.data);
      logger.info(event.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    final String? directoryPath = await getDirectoryPath();
                    if (directoryPath == null) {
                      // Operation was canceled by the user.
                      return;
                    }

                    scan(p: directoryPath);
                  },
                  child: const Text("Select folder")),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(100),
                    1: FixedColumnWidth(100),
                    2: FixedColumnWidth(100),
                    3: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Header Row
                    TableRow(
                      children: [
                        TableCell(
                            child: InkWell(
                          onTap: () {
                            if (compareResults != null) {
                              compareResults!.field0
                                  .sort((a, b) => a.index.compareTo(b.index));
                              asc = false;
                              setState(() {});
                            }
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('Index',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  Icon(Icons.refresh)
                                ],
                              )),
                        )),
                        const TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Group ID',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        TableCell(
                            child: InkWell(
                          onTap: () {
                            if (compareResults != null) {
                              if (!asc) {
                                compareResults!.field0.sort(
                                    (a, b) => a.fileSize.compareTo(b.fileSize));
                              } else {
                                compareResults!.field0.sort((a, b) =>
                                    -a.fileSize.compareTo(b.fileSize));
                              }

                              asc = !asc;

                              setState(() {});
                            }
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text('File Size',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  if (asc)
                                    const Icon(Icons.arrow_upward)
                                  else
                                    const Icon(Icons.arrow_downward)
                                ],
                              )),
                        )),
                        const TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Files',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                      ],
                    ),
                    // Data Rows
                    for (var result in compareResults?.field0 ?? [])
                      TableRow(
                        children: [
                          TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(result.index.toString()))),
                          TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(result.groupId.toString()))),
                          TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(filesize(result.fileSize)))),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(result.files
                                  .map((file) => file.path)
                                  .join(', ')),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
