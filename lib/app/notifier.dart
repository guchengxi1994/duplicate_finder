import 'package:duplicate_finder/src/rust/api/scanner_api.dart';
import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier_state.dart';

class ScannerNotifier extends Notifier<ScannerState> {
  @override
  ScannerState build() {
    return const ScannerState();
  }

  refresh() {
    state = state.copyWith(compareResults: null, rows: 0, stage: "", path: "");
  }

  startScan() async {
    refresh();
    final String? directoryPath = await getDirectoryPath();
    if (directoryPath == null) {
      return;
    }

    state = state.copyWith(path: directoryPath);
    scan(p: directoryPath);
  }

  changeAsc() {
    bool b = !state.asc;
    if (b) {
      state = state.copyWith(
          asc: b,
          results: state.results
            ..sort((a, b) => a.fileSize.compareTo(b.fileSize)));
    } else {
      state = state.copyWith(
          asc: b,
          results: state.results
            ..sort((a, b) => -a.fileSize.compareTo(b.fileSize)));
    }
  }

  refreshList() {
    state = state.copyWith(
        asc: true,
        results: state.results..sort((a, b) => a.index.compareTo(b.index)));
  }

  changeShowAll() {
    bool b = !state.showAll;

    if (b) {
      state = state.copyWith(
          results: state.compareResults?.field0 ?? [], showAll: b);
      return;
    } else {
      state = state.copyWith(
          showAll: b,
          results: state.results.where((v) => v.files.length > 1).toList());
    }
  }

  changeStage(String s) {
    state = state.copyWith(stage: s);
  }

  changeItems(CompareResults results) {
    state = state.copyWith(compareResults: results, results: results.field0);
  }
}

final scannerNotifierProvider =
    NotifierProvider<ScannerNotifier, ScannerState>(ScannerNotifier.new);
