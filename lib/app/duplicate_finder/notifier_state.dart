import 'package:scanner/src/rust/scanner/compare_result.dart';

class ScannerState {
  final String stage;

  /// all files
  final List<CompareResult> compareResults;
  final String path;
  final bool showAll;
  final int totalFileCount;

  /// files show
  final List<CompareResult> results;
  final bool asc;
  final bool scanning;
  final int comparedFileCount;

  const ScannerState({
    this.stage = "",
    this.compareResults = const [],
    this.path = "",
    this.showAll = true,
    this.results = const [],
    this.asc = true,
    this.scanning = false,
    this.totalFileCount = 0,
    this.comparedFileCount = 0,
  });

  ScannerState copyWith({
    String? stage,
    List<CompareResult>? compareResults,
    String? path,
    bool? showAll,
    List<CompareResult>? results,
    bool? asc,
    bool? scanning,
    int? totalFileCount,
    int? comparedFileCount,
  }) {
    return ScannerState(
      stage: stage ?? this.stage,
      compareResults: compareResults ?? this.compareResults,
      path: path ?? this.path,
      showAll: showAll ?? this.showAll,
      results: results ?? this.results,
      asc: asc ?? this.asc,
      scanning: scanning ?? this.scanning,
      totalFileCount: totalFileCount ?? this.totalFileCount,
      comparedFileCount: comparedFileCount ?? this.comparedFileCount,
    );
  }
}
