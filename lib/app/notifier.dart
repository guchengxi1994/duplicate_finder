import 'package:duplicate_finder/src/rust/api/scanner_api.dart';
import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';
import 'package:duplicate_finder/src/rust/scanner/event.dart';
import 'package:duplicate_finder/src/rust/scanner/file.dart';
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

    state = state.copyWith(
        path: directoryPath, scanning: true, compareResults: [], results: []);
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

  changeStage(ResEvent s) {
    final v = switch (s) {
      ResEvent_ScannerEvent() => eventToString(s: s),
      ResEvent_CompareEvent() => "${state.stage};${eventToString(s: s)}",
      ResEvent_DoneEvent() => "Done",
    };

    if (v == "Done") {
      done();
    } else {
      state = state.copyWith(stage: v);
    }
  }

  addItem(CompareResult result) {
    state = state.copyWith(
        compareResults: [...state.compareResults, result],
        results: [...state.compareResults, result],
        showAll: true,
        asc: true);
  }

  updateCompareResult(CompareResult result) {
    state = state.copyWith(
        compareResults: state.compareResults
            .map((e) => e.index == result.index ? result : e)
            .toList(),
        results: state.results
            .map((e) => e.index == result.index ? result : e)
            .toList());
  }

  removeFileFromList(BigInt resultId, File s) {
    final result = state.compareResults.firstWhere((e) => e.index == resultId);

    final c = CompareResult(
        index: result.index,
        fileSize: result.fileSize,
        allSameFiles: result.allSameFiles
            .map((v) => v.where((e) => e.path != s.path).toList())
            .toList(),
        count: result.count);

    state = state.copyWith(
        compareResults: state.compareResults
            .map((e) => e.index == resultId ? c : e)
            .toList(),
        results:
            state.results.map((e) => e.index == resultId ? c : e).toList());
  }
}

final scannerNotifierProvider =
    NotifierProvider<ScannerNotifier, ScannerState>(ScannerNotifier.new);
