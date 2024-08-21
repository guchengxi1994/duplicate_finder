import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:duplicate_finder/src/rust/api/tools_api.dart';
import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';
import 'package:duplicate_finder/src/rust/scanner/file.dart' show File;
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier.dart';
import 'toast_utils.dart';

class ScannerDatasource extends DataTableSource {
  final BuildContext context;
  late List<CompareResult> results;

  ScannerDatasource(this.context, this.results);

  @override
  DataRow2? getRow(int index) {
    return DataRow2(
      specificRowHeight: results[index].count.toDouble() * 50 + 16,
      cells: [
        DataCell(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(results[index].index.toString()))),
        DataCell(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(filesize(results[index].fileSize)))),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: buildResult(results[index]),
          ),
        ),
      ],
    );
  }

  Widget buildResult(CompareResult result) {
    return ListView.builder(
        itemCount: result.allSameFiles.length,
        itemBuilder: (c, i) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: result.allSameFiles[i].length * 50,
                      child: Column(
                        children: result.allSameFiles[i]
                            .mapIndexed((i, v) => DatasourceItem(
                                  index: i + 1,
                                  file: v,
                                  id: result.index,
                                  onFileRemoved: (file) {},
                                ))
                            .toList(),
                      ),
                    ),
                    if (result.allSameFiles[i].length > 1)
                      Positioned(
                        right: 10,
                        child: SizedBox(
                          height: result.allSameFiles[i].length * 50,
                          width: 250,
                          child: Center(
                            child: AnimatedTextKit(animatedTexts: [
                              ColorizeAnimatedText(
                                'These files are the same',
                                textStyle: colorizeTextStyle,
                                colors: colorizeColors,
                              ),
                            ], isRepeatingAnimation: true, repeatForever: true),
                          ),
                        ),
                      )
                  ],
                )),
          );
        });
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => results.length;

  @override
  int get selectedRowCount => 0;
}

const fontSize = 20.0;

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: fontSize,
  fontFamily: 'Horizon',
);

typedef OnFileRemoved = void Function(File file);
typedef OnFileDeleted = void Function(File file);
typedef OnFileOpened = void Function(String path);

class DatasourceItem extends ConsumerStatefulWidget {
  const DatasourceItem(
      {super.key,
      required this.file,
      required this.index,
      required this.id,
      this.onFileOpened,
      this.onFileDeleted,
      this.onFileRemoved});
  final File file;
  final int index;
  final BigInt id;
  final OnFileDeleted? onFileDeleted;
  final OnFileRemoved? onFileRemoved;
  final OnFileOpened? onFileOpened;

  @override
  ConsumerState<DatasourceItem> createState() => _DatasourceItemState();
}

class _DatasourceItemState extends ConsumerState<DatasourceItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 0.4 * MediaQuery.of(context).size.width,
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: Tooltip(
                  waitDuration: const Duration(seconds: 1),
                  message: widget.file.path,
                  child: AutoSizeText(
                    "${widget.index}. ${widget.file.name}",
                    maxLines: 1,
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                if (isHover)
                  InkWell(
                    onTap: () {
                      openFile(s: widget.file.path);
                      if (widget.onFileOpened != null) {
                        widget.onFileOpened!(widget.file.path);
                      }
                    },
                    child: const Tooltip(
                        message: "Open in directory",
                        child: Icon(Icons.file_open_outlined)),
                  ),
                const SizedBox(
                  width: 10,
                ),
                if (isHover)
                  InkWell(
                    onTap: () {
                      removeFile(s: widget.file.path).then((value) {
                        if (value.success) {
                          ToastUtils.sucess(null, title: value.message);
                          ref
                              .read(scannerNotifierProvider.notifier)
                              .removeFileFromList(widget.id, widget.file);
                          if (widget.onFileRemoved != null) {
                            widget.onFileRemoved!(widget.file);
                          }
                        } else {
                          ToastUtils.error(null, title: value.message);
                        }
                      });
                    },
                    child: const Tooltip(
                      message: "Move to trash bin",
                      child: Icon(Icons.highlight_remove),
                    ),
                  )
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
