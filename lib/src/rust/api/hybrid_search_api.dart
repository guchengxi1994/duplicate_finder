// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.5.1.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../hybrid_search.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<List<String>> hybridSearchSync(
        {required String p,
        required bool caseSensitive,
        required List<String> startsWith,
        required List<String> endsWith,
        required List<String> includes,
        required List<String> excludes,
        required List<String> regex,
        required SearchType searchType}) =>
    RustLib.instance.api.crateApiHybridSearchApiHybridSearchSync(
        p: p,
        caseSensitive: caseSensitive,
        startsWith: startsWith,
        endsWith: endsWith,
        includes: includes,
        excludes: excludes,
        regex: regex,
        searchType: searchType);

Stream<HybridSearchDetail> searchStream() =>
    RustLib.instance.api.crateApiHybridSearchApiSearchStream();

Future<void> hybridSearchStream(
        {required String p,
        required bool caseSensitive,
        required List<String> startsWith,
        required List<String> endsWith,
        required List<String> includes,
        required List<String> excludes,
        required List<String> regex,
        required SearchType searchType}) =>
    RustLib.instance.api.crateApiHybridSearchApiHybridSearchStream(
        p: p,
        caseSensitive: caseSensitive,
        startsWith: startsWith,
        endsWith: endsWith,
        includes: includes,
        excludes: excludes,
        regex: regex,
        searchType: searchType);
