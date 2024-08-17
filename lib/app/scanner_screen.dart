import 'package:data_table_2/data_table_2.dart';
import 'package:duplicate_finder/app/datasource.dart';
import 'package:duplicate_finder/src/rust/api/scanner_api.dart';
import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';
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
  final eStream = eventStream();
  final rStream = scannerRefreshResultsStream();

  @override
  void initState() {
    super.initState();

    eStream.listen((event) {
      ref.read(scannerNotifierProvider.notifier).changeStage(event.data);

      if (event.data == "done") {
        ref.read(scannerNotifierProvider.notifier).done();
      }
    });

    rStream.listen((event) {
      ref.read(scannerNotifierProvider.notifier).addItem(event);
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
                      onPressed: state.scanning
                          ? null
                          : () async {
                              ref
                                  .read(scannerNotifierProvider.notifier)
                                  .startScan();
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
              child: buildTable(state.results),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTable(List<CompareResult> results) {
    if (results.isEmpty) {
      return Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Image.asset("assets/icon.jpeg"),
        ),
      );
    }

    return PaginatedDataTable2(
        columns: columns, source: ScannerDatasource(context, results));
  }

  List<DataColumn> get columns => _getColumns();

  List<DataColumn> _getColumns() {
    final asc = ref.watch(scannerNotifierProvider.select((v) => v.asc));
    final showAll = ref.watch(scannerNotifierProvider.select((v) => v.showAll));
    final scanning =
        ref.watch(scannerNotifierProvider.select((v) => v.scanning));

    return [
      DataColumn2(
          fixedWidth: 150,
          label: InkWell(
            onTap: scanning
                ? null
                : () {
                    ref.read(scannerNotifierProvider.notifier).refreshList();
                  },
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Index',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Spacer(),
                    Icon(Icons.refresh)
                  ],
                )),
          )),
      DataColumn2(
          fixedWidth: 150,
          label: InkWell(
            onTap: scanning
                ? null
                : () {
                    ref.read(scannerNotifierProvider.notifier).changeAsc();
                  },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text('File Size',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    if (asc)
                      const Icon(Icons.arrow_upward)
                    else
                      const Icon(Icons.arrow_downward)
                  ],
                )),
          )),
      DataColumn2(
          label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Files',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  InkWell(
                    onTap: scanning
                        ? null
                        : () {
                            ref
                                .read(scannerNotifierProvider.notifier)
                                .changeShowAll();
                          },
                    child: showAll
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ))),
    ];
  }
}
