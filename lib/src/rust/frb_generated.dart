// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.5.1.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

import 'api/project_api.dart';
import 'api/public.dart';
import 'api/scanner_api.dart';
import 'api/simple.dart';
import 'api/tools_api.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'frb_generated.io.dart'
    if (dart.library.js_interop) 'frb_generated.web.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'project.dart';
import 'scanner/compare_result.dart';
import 'scanner/event.dart';
import 'scanner/file.dart';

/// Main entrypoint of the Rust API
class RustLib extends BaseEntrypoint<RustLibApi, RustLibApiImpl, RustLibWire> {
  @internal
  static final instance = RustLib._();

  RustLib._();

  /// Initialize flutter_rust_bridge
  static Future<void> init({
    RustLibApi? api,
    BaseHandler? handler,
    ExternalLibrary? externalLibrary,
  }) async {
    await instance.initImpl(
      api: api,
      handler: handler,
      externalLibrary: externalLibrary,
    );
  }

  /// Initialize flutter_rust_bridge in mock mode.
  /// No libraries for FFI are loaded.
  static void initMock({
    required RustLibApi api,
  }) {
    instance.initMockImpl(
      api: api,
    );
  }

  /// Dispose flutter_rust_bridge
  ///
  /// The call to this function is optional, since flutter_rust_bridge (and everything else)
  /// is automatically disposed when the app stops.
  static void dispose() => instance.disposeImpl();

  @override
  ApiImplConstructor<RustLibApiImpl, RustLibWire> get apiImplConstructor =>
      RustLibApiImpl.new;

  @override
  WireConstructor<RustLibWire> get wireConstructor =>
      RustLibWire.fromExternalLibrary;

  @override
  Future<void> executeRustInitializers() async {
    await api.crateApiSimpleInitApp();
  }

  @override
  ExternalLibraryLoaderConfig get defaultExternalLibraryLoaderConfig =>
      kDefaultExternalLibraryLoaderConfig;

  @override
  String get codegenVersion => '2.5.1';

  @override
  int get rustContentHash => -2117530524;

  static const kDefaultExternalLibraryLoaderConfig =
      ExternalLibraryLoaderConfig(
    stem: 'rust_lib_duplicate_finder',
    ioDirectory: 'rust/target/release/',
    webPrefix: 'pkg/',
  );
}

abstract class RustLibApi extends BaseApi {
  Future<void> crateApiProjectApiProjectScan({required String p});

  Stream<ProjectDetail> crateApiProjectApiProjectScanStream();

  Future<OperationResult> crateApiPublicOperationResultFileRemoveFailed();

  Future<OperationResult> crateApiPublicOperationResultFileRemoveOk();

  Stream<ResEvent> crateApiScannerApiEventStream();

  String crateApiScannerApiEventToString({required ResEvent s});

  Future<void> crateApiScannerApiScan({required String p});

  Stream<CompareResult> crateApiScannerApiScannerRefreshResultsStream();

  String crateApiSimpleGreet({required String name});

  Future<void> crateApiSimpleInitApp();

  Future<void> crateApiToolsApiOpenFile({required String s});

  Future<OperationResult> crateApiToolsApiRemoveFile({required String s});
}

class RustLibApiImpl extends RustLibApiImplPlatform implements RustLibApi {
  RustLibApiImpl({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @override
  Future<void> crateApiProjectApiProjectScan({required String p}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(p, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 1, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiProjectApiProjectScanConstMeta,
      argValues: [p],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiProjectApiProjectScanConstMeta =>
      const TaskConstMeta(
        debugName: "project_scan",
        argNames: ["p"],
      );

  @override
  Stream<ProjectDetail> crateApiProjectApiProjectScanStream() {
    final s = RustStreamSink<ProjectDetail>();
    handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_StreamSink_project_detail_Sse(s, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 2)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiProjectApiProjectScanStreamConstMeta,
      argValues: [s],
      apiImpl: this,
    ));
    return s.stream;
  }

  TaskConstMeta get kCrateApiProjectApiProjectScanStreamConstMeta =>
      const TaskConstMeta(
        debugName: "project_scan_stream",
        argNames: ["s"],
      );

  @override
  Future<OperationResult> crateApiPublicOperationResultFileRemoveFailed() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 3, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_operation_result,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiPublicOperationResultFileRemoveFailedConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiPublicOperationResultFileRemoveFailedConstMeta =>
      const TaskConstMeta(
        debugName: "operation_result_file_remove_failed",
        argNames: [],
      );

  @override
  Future<OperationResult> crateApiPublicOperationResultFileRemoveOk() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 4, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_operation_result,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiPublicOperationResultFileRemoveOkConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiPublicOperationResultFileRemoveOkConstMeta =>
      const TaskConstMeta(
        debugName: "operation_result_file_remove_ok",
        argNames: [],
      );

  @override
  Stream<ResEvent> crateApiScannerApiEventStream() {
    final s = RustStreamSink<ResEvent>();
    handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_StreamSink_res_event_Sse(s, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 5)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiScannerApiEventStreamConstMeta,
      argValues: [s],
      apiImpl: this,
    ));
    return s.stream;
  }

  TaskConstMeta get kCrateApiScannerApiEventStreamConstMeta =>
      const TaskConstMeta(
        debugName: "event_stream",
        argNames: ["s"],
      );

  @override
  String crateApiScannerApiEventToString({required ResEvent s}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_box_autoadd_res_event(s, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 6)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiScannerApiEventToStringConstMeta,
      argValues: [s],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiScannerApiEventToStringConstMeta =>
      const TaskConstMeta(
        debugName: "event_to_string",
        argNames: ["s"],
      );

  @override
  Future<void> crateApiScannerApiScan({required String p}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(p, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 7, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiScannerApiScanConstMeta,
      argValues: [p],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiScannerApiScanConstMeta => const TaskConstMeta(
        debugName: "scan",
        argNames: ["p"],
      );

  @override
  Stream<CompareResult> crateApiScannerApiScannerRefreshResultsStream() {
    final s = RustStreamSink<CompareResult>();
    handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_StreamSink_compare_result_Sse(s, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 8)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiScannerApiScannerRefreshResultsStreamConstMeta,
      argValues: [s],
      apiImpl: this,
    ));
    return s.stream;
  }

  TaskConstMeta get kCrateApiScannerApiScannerRefreshResultsStreamConstMeta =>
      const TaskConstMeta(
        debugName: "scanner_refresh_results_stream",
        argNames: ["s"],
      );

  @override
  String crateApiSimpleGreet({required String name}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(name, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 9)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleGreetConstMeta,
      argValues: [name],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleGreetConstMeta => const TaskConstMeta(
        debugName: "greet",
        argNames: ["name"],
      );

  @override
  Future<void> crateApiSimpleInitApp() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 10, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleInitAppConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleInitAppConstMeta => const TaskConstMeta(
        debugName: "init_app",
        argNames: [],
      );

  @override
  Future<void> crateApiToolsApiOpenFile({required String s}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(s, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 11, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiToolsApiOpenFileConstMeta,
      argValues: [s],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiToolsApiOpenFileConstMeta => const TaskConstMeta(
        debugName: "open_file",
        argNames: ["s"],
      );

  @override
  Future<OperationResult> crateApiToolsApiRemoveFile({required String s}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(s, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 12, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_operation_result,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiToolsApiRemoveFileConstMeta,
      argValues: [s],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiToolsApiRemoveFileConstMeta => const TaskConstMeta(
        debugName: "remove_file",
        argNames: ["s"],
      );

  @protected
  AnyhowException dco_decode_AnyhowException(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return AnyhowException(raw as String);
  }

  @protected
  RustStreamSink<CompareResult> dco_decode_StreamSink_compare_result_Sse(
      dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    throw UnimplementedError();
  }

  @protected
  RustStreamSink<ProjectDetail> dco_decode_StreamSink_project_detail_Sse(
      dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    throw UnimplementedError();
  }

  @protected
  RustStreamSink<ResEvent> dco_decode_StreamSink_res_event_Sse(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    throw UnimplementedError();
  }

  @protected
  String dco_decode_String(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as String;
  }

  @protected
  bool dco_decode_bool(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as bool;
  }

  @protected
  CompareEvent dco_decode_box_autoadd_compare_event(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_compare_event(raw);
  }

  @protected
  DoneEvent dco_decode_box_autoadd_done_event(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_done_event(raw);
  }

  @protected
  ResEvent dco_decode_box_autoadd_res_event(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_res_event(raw);
  }

  @protected
  ScannerEvent dco_decode_box_autoadd_scanner_event(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_scanner_event(raw);
  }

  @protected
  CompareEvent dco_decode_compare_event(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return CompareEvent(
      eventType: dco_decode_String(arr[0]),
      duration: dco_decode_f_32(arr[1]),
    );
  }

  @protected
  CompareResult dco_decode_compare_result(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return CompareResult(
      index: dco_decode_u_64(arr[0]),
      fileSize: dco_decode_u_64(arr[1]),
      allSameFiles: dco_decode_list_list_file(arr[2]),
      count: dco_decode_u_64(arr[3]),
    );
  }

  @protected
  DoneEvent dco_decode_done_event(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return DoneEvent(
      eventType: dco_decode_String(arr[0]),
      isDone: dco_decode_bool(arr[1]),
    );
  }

  @protected
  double dco_decode_f_32(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as double;
  }

  @protected
  File dco_decode_file(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return File(
      path: dco_decode_String(arr[0]),
      name: dco_decode_String(arr[1]),
      size: dco_decode_u_64(arr[2]),
    );
  }

  @protected
  List<File> dco_decode_list_file(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_file).toList();
  }

  @protected
  List<List<File>> dco_decode_list_list_file(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_list_file).toList();
  }

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as Uint8List;
  }

  @protected
  OperationResult dco_decode_operation_result(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return OperationResult(
      success: dco_decode_bool(arr[0]),
      message: dco_decode_String(arr[1]),
    );
  }

  @protected
  ProjectDetail dco_decode_project_detail(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return ProjectDetail(
      path: dco_decode_String(arr[0]),
      size: dco_decode_u_64(arr[1]),
    );
  }

  @protected
  ResEvent dco_decode_res_event(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    switch (raw[0]) {
      case 0:
        return ResEvent_ScannerEvent(
          dco_decode_box_autoadd_scanner_event(raw[1]),
        );
      case 1:
        return ResEvent_CompareEvent(
          dco_decode_box_autoadd_compare_event(raw[1]),
        );
      case 2:
        return ResEvent_DoneEvent(
          dco_decode_box_autoadd_done_event(raw[1]),
        );
      default:
        throw Exception("unreachable");
    }
  }

  @protected
  ScannerEvent dco_decode_scanner_event(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return ScannerEvent(
      eventType: dco_decode_String(arr[0]),
      count: dco_decode_u_64(arr[1]),
      duration: dco_decode_f_32(arr[2]),
    );
  }

  @protected
  BigInt dco_decode_u_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeU64(raw);
  }

  @protected
  int dco_decode_u_8(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as int;
  }

  @protected
  void dco_decode_unit(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return;
  }

  @protected
  AnyhowException sse_decode_AnyhowException(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_String(deserializer);
    return AnyhowException(inner);
  }

  @protected
  RustStreamSink<CompareResult> sse_decode_StreamSink_compare_result_Sse(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    throw UnimplementedError('Unreachable ()');
  }

  @protected
  RustStreamSink<ProjectDetail> sse_decode_StreamSink_project_detail_Sse(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    throw UnimplementedError('Unreachable ()');
  }

  @protected
  RustStreamSink<ResEvent> sse_decode_StreamSink_res_event_Sse(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    throw UnimplementedError('Unreachable ()');
  }

  @protected
  String sse_decode_String(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_list_prim_u_8_strict(deserializer);
    return utf8.decoder.convert(inner);
  }

  @protected
  bool sse_decode_bool(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8() != 0;
  }

  @protected
  CompareEvent sse_decode_box_autoadd_compare_event(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_compare_event(deserializer));
  }

  @protected
  DoneEvent sse_decode_box_autoadd_done_event(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_done_event(deserializer));
  }

  @protected
  ResEvent sse_decode_box_autoadd_res_event(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_res_event(deserializer));
  }

  @protected
  ScannerEvent sse_decode_box_autoadd_scanner_event(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_scanner_event(deserializer));
  }

  @protected
  CompareEvent sse_decode_compare_event(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_eventType = sse_decode_String(deserializer);
    var var_duration = sse_decode_f_32(deserializer);
    return CompareEvent(eventType: var_eventType, duration: var_duration);
  }

  @protected
  CompareResult sse_decode_compare_result(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_index = sse_decode_u_64(deserializer);
    var var_fileSize = sse_decode_u_64(deserializer);
    var var_allSameFiles = sse_decode_list_list_file(deserializer);
    var var_count = sse_decode_u_64(deserializer);
    return CompareResult(
        index: var_index,
        fileSize: var_fileSize,
        allSameFiles: var_allSameFiles,
        count: var_count);
  }

  @protected
  DoneEvent sse_decode_done_event(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_eventType = sse_decode_String(deserializer);
    var var_isDone = sse_decode_bool(deserializer);
    return DoneEvent(eventType: var_eventType, isDone: var_isDone);
  }

  @protected
  double sse_decode_f_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getFloat32();
  }

  @protected
  File sse_decode_file(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_path = sse_decode_String(deserializer);
    var var_name = sse_decode_String(deserializer);
    var var_size = sse_decode_u_64(deserializer);
    return File(path: var_path, name: var_name, size: var_size);
  }

  @protected
  List<File> sse_decode_list_file(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <File>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_file(deserializer));
    }
    return ans_;
  }

  @protected
  List<List<File>> sse_decode_list_list_file(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <List<File>>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_list_file(deserializer));
    }
    return ans_;
  }

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var len_ = sse_decode_i_32(deserializer);
    return deserializer.buffer.getUint8List(len_);
  }

  @protected
  OperationResult sse_decode_operation_result(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_success = sse_decode_bool(deserializer);
    var var_message = sse_decode_String(deserializer);
    return OperationResult(success: var_success, message: var_message);
  }

  @protected
  ProjectDetail sse_decode_project_detail(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_path = sse_decode_String(deserializer);
    var var_size = sse_decode_u_64(deserializer);
    return ProjectDetail(path: var_path, size: var_size);
  }

  @protected
  ResEvent sse_decode_res_event(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var tag_ = sse_decode_i_32(deserializer);
    switch (tag_) {
      case 0:
        var var_field0 = sse_decode_box_autoadd_scanner_event(deserializer);
        return ResEvent_ScannerEvent(var_field0);
      case 1:
        var var_field0 = sse_decode_box_autoadd_compare_event(deserializer);
        return ResEvent_CompareEvent(var_field0);
      case 2:
        var var_field0 = sse_decode_box_autoadd_done_event(deserializer);
        return ResEvent_DoneEvent(var_field0);
      default:
        throw UnimplementedError('');
    }
  }

  @protected
  ScannerEvent sse_decode_scanner_event(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_eventType = sse_decode_String(deserializer);
    var var_count = sse_decode_u_64(deserializer);
    var var_duration = sse_decode_f_32(deserializer);
    return ScannerEvent(
        eventType: var_eventType, count: var_count, duration: var_duration);
  }

  @protected
  BigInt sse_decode_u_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getBigUint64();
  }

  @protected
  int sse_decode_u_8(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8();
  }

  @protected
  void sse_decode_unit(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  int sse_decode_i_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getInt32();
  }

  @protected
  void sse_encode_AnyhowException(
      AnyhowException self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.message, serializer);
  }

  @protected
  void sse_encode_StreamSink_compare_result_Sse(
      RustStreamSink<CompareResult> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(
        self.setupAndSerialize(
            codec: SseCodec(
          decodeSuccessData: sse_decode_compare_result,
          decodeErrorData: sse_decode_AnyhowException,
        )),
        serializer);
  }

  @protected
  void sse_encode_StreamSink_project_detail_Sse(
      RustStreamSink<ProjectDetail> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(
        self.setupAndSerialize(
            codec: SseCodec(
          decodeSuccessData: sse_decode_project_detail,
          decodeErrorData: sse_decode_AnyhowException,
        )),
        serializer);
  }

  @protected
  void sse_encode_StreamSink_res_event_Sse(
      RustStreamSink<ResEvent> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(
        self.setupAndSerialize(
            codec: SseCodec(
          decodeSuccessData: sse_decode_res_event,
          decodeErrorData: sse_decode_AnyhowException,
        )),
        serializer);
  }

  @protected
  void sse_encode_String(String self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_list_prim_u_8_strict(utf8.encoder.convert(self), serializer);
  }

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self ? 1 : 0);
  }

  @protected
  void sse_encode_box_autoadd_compare_event(
      CompareEvent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_compare_event(self, serializer);
  }

  @protected
  void sse_encode_box_autoadd_done_event(
      DoneEvent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_done_event(self, serializer);
  }

  @protected
  void sse_encode_box_autoadd_res_event(
      ResEvent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_res_event(self, serializer);
  }

  @protected
  void sse_encode_box_autoadd_scanner_event(
      ScannerEvent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_scanner_event(self, serializer);
  }

  @protected
  void sse_encode_compare_event(CompareEvent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.eventType, serializer);
    sse_encode_f_32(self.duration, serializer);
  }

  @protected
  void sse_encode_compare_result(CompareResult self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_u_64(self.index, serializer);
    sse_encode_u_64(self.fileSize, serializer);
    sse_encode_list_list_file(self.allSameFiles, serializer);
    sse_encode_u_64(self.count, serializer);
  }

  @protected
  void sse_encode_done_event(DoneEvent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.eventType, serializer);
    sse_encode_bool(self.isDone, serializer);
  }

  @protected
  void sse_encode_f_32(double self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putFloat32(self);
  }

  @protected
  void sse_encode_file(File self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.path, serializer);
    sse_encode_String(self.name, serializer);
    sse_encode_u_64(self.size, serializer);
  }

  @protected
  void sse_encode_list_file(List<File> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_file(item, serializer);
    }
  }

  @protected
  void sse_encode_list_list_file(
      List<List<File>> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_list_file(item, serializer);
    }
  }

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    serializer.buffer.putUint8List(self);
  }

  @protected
  void sse_encode_operation_result(
      OperationResult self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_bool(self.success, serializer);
    sse_encode_String(self.message, serializer);
  }

  @protected
  void sse_encode_project_detail(ProjectDetail self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.path, serializer);
    sse_encode_u_64(self.size, serializer);
  }

  @protected
  void sse_encode_res_event(ResEvent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    switch (self) {
      case ResEvent_ScannerEvent(field0: final field0):
        sse_encode_i_32(0, serializer);
        sse_encode_box_autoadd_scanner_event(field0, serializer);
      case ResEvent_CompareEvent(field0: final field0):
        sse_encode_i_32(1, serializer);
        sse_encode_box_autoadd_compare_event(field0, serializer);
      case ResEvent_DoneEvent(field0: final field0):
        sse_encode_i_32(2, serializer);
        sse_encode_box_autoadd_done_event(field0, serializer);
      default:
        throw UnimplementedError('');
    }
  }

  @protected
  void sse_encode_scanner_event(ScannerEvent self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.eventType, serializer);
    sse_encode_u_64(self.count, serializer);
    sse_encode_f_32(self.duration, serializer);
  }

  @protected
  void sse_encode_u_64(BigInt self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putBigUint64(self);
  }

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self);
  }

  @protected
  void sse_encode_unit(void self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putInt32(self);
  }
}
