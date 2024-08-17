import 'package:duplicate_finder/src/rust/scanner/compare_result.dart';

class ScannerState {
  final String stage;
  final int rows;

  /// all files
  final List<CompareResult> compareResults;
  final String path;
  final bool showAll;

  /// files show
  final List<CompareResult> results;
  final bool asc;
  final bool scanning;

  const ScannerState({
    this.stage = "",
    this.rows = 0,
    this.compareResults = const [],
    this.path = "",
    this.showAll = true,
    this.results = const [],
    this.asc = true,
    this.scanning = false,
  });

  ScannerState copyWith({
    String? stage,
    int? rows,
    List<CompareResult>? compareResults,
    String? path,
    bool? showAll,
    List<CompareResult>? results,
    bool? asc,
    bool? scanning,
  }) {
    return ScannerState(
      stage: stage ?? this.stage,
      rows: rows ?? this.rows,
      compareResults: compareResults ?? this.compareResults,
      path: path ?? this.path,
      showAll: showAll ?? this.showAll,
      results: results ?? this.results,
      asc: asc ?? this.asc,
      scanning: scanning ?? this.scanning,
    );
  }
}
