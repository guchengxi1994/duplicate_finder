import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';

class ScannerState {
  final String stage;
  final int rows;
  final CompareResults? compareResults;
  final String path;
  final bool showAll;
  final List<CompareResult> results;
  final bool asc;

  const ScannerState({
    this.stage = "",
    this.rows = 0,
    this.compareResults,
    this.path = "",
    this.showAll = true,
    this.results = const [],
    this.asc = true,
  });

  ScannerState copyWith({
    String? stage,
    int? rows,
    CompareResults? compareResults,
    String? path,
    bool? showAll,
    List<CompareResult>? results,
    bool? asc,
  }) {
    return ScannerState(
      stage: stage ?? this.stage,
      rows: rows ?? this.rows,
      compareResults: compareResults ?? this.compareResults,
      path: path ?? this.path,
      showAll: showAll ?? this.showAll,
      results: results ?? this.results,
      asc: asc ?? this.asc,
    );
  }
}
