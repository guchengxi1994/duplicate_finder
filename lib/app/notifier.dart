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
    state = state.copyWith(
        compareResults: [], rows: 0, stage: "", path: "", scanning: false);
  }

  done() {
    state = state.copyWith(scanning: false);
  }

  startScan() async {
    refresh();
    final String? directoryPath = await getDirectoryPath();
    if (directoryPath == null) {
      return;
    }

    state = state.copyWith(path: directoryPath, scanning: true);
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
      state = state.copyWith(results: state.compareResults, showAll: b);
      return;
    } else {
      state = state.copyWith(
          showAll: b,
          results: state.results.where((v) {
            for (final i in v.allSameFiles) {
              if (i.length > 1) {
                return true;
              }
            }
            return false;
          }).toList());
    }
  }

  changeStage(String s) {
    state = state.copyWith(stage: s);
  }

  @Deprecated("unused")
  changeItems(List<CompareResult> results) {
    state = state.copyWith(compareResults: results, results: results);
  }

  addItem(CompareResult result) {
    state = state.copyWith(
        compareResults: [...state.compareResults, result],
        results: [...state.compareResults, result],
        showAll: true,
        asc: true);
  }
}

final scannerNotifierProvider =
    NotifierProvider<ScannerNotifier, ScannerState>(ScannerNotifier.new);