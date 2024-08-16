import 'package:data_table_2/data_table_2.dart';
import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';

class ScannerDatasource extends DataTableSource {
  final BuildContext context;
  late List<CompareResult> results;

  ScannerDatasource(this.context, this.results);

  @override
  DataRow2? getRow(int index) {
    return DataRow2(
      specificRowHeight: results[index].files.length * 50,
      cells: [
        DataCell(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(results[index].index.toString()))),
        DataCell(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(filesize(results[index].fileSize)))),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(results[index].files.map((file) => file.path).join(', ')),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => results.length;

  @override
  int get selectedRowCount => 0;
}
