import 'package:duplicate_finder/src/rust/api/scanner_api.dart';
import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier.dart';
import 'style.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  final stream = scannerCompareResultsStream();
  final eStream = eventStream();

  @override
  void initState() {
    super.initState();
    stream.listen((event) {
      ref.read(scannerNotifierProvider.notifier).changeItems(event);
    });

    eStream.listen((event) {
      ref.read(scannerNotifierProvider.notifier).changeStage(event.data);
    });
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scannerNotifierProvider);
    controller.text = state.path;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller,
                    enabled: false,
                    decoration: AppStyle.inputDecorationWithHintAndLabel(
                        "Please select a folder to scan", "Folder Path"),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        ref.read(scannerNotifierProvider.notifier).startScan();
                      },
                      child: const Text("Select folder"))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  const Spacer(),
                  Text(state.stage),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(100),
                    1: FixedColumnWidth(100),
                    2: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Header Row
                    TableRow(
                      children: [
                        TableCell(
                            child: InkWell(
                          onTap: () {
                            ref
                                .read(scannerNotifierProvider.notifier)
                                .refreshList();
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
                        TableCell(
                            child: InkWell(
                          onTap: () {
                            ref
                                .read(scannerNotifierProvider.notifier)
                                .changeAsc();
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text('File Size',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  if (state.asc)
                                    const Icon(Icons.arrow_upward)
                                  else
                                    const Icon(Icons.arrow_downward)
                                ],
                              )),
                        )),
                        TableCell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text('Files',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        ref
                                            .read(scannerNotifierProvider
                                                .notifier)
                                            .changeShowAll();
                                      },
                                      child: state.showAll
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                    // Data Rows
                    for (CompareResult result in state.results)
                      TableRow(
                        children: [
                          TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(result.index.toString()))),
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
