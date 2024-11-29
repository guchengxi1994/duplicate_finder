// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.5.1.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../scanner/compare_result.dart';
import '../scanner/event.dart';
import '../scanner/file.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Stream<CompareResult> scannerRefreshResultsStream() =>
    RustLib.instance.api.crateApiScannerApiScannerRefreshResultsStream();

Stream<ResEvent> eventStream() =>
    RustLib.instance.api.crateApiScannerApiEventStream();

Future<void> scan({required String p}) =>
    RustLib.instance.api.crateApiScannerApiScan(p: p);

String eventToString({required ResEvent s}) =>
    RustLib.instance.api.crateApiScannerApiEventToString(s: s);
