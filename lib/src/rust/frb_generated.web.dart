// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.2.0.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

// Static analysis wrongly picks the IO variant, thus ignore this
// ignore_for_file: argument_type_not_assignable

import 'api/public.dart';
import 'api/scanner_api.dart';
import 'api/simple.dart';
import 'api/tools_api.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated_web.dart';
import 'scanner/compare_result.dart';
import 'scanner/event.dart';
import 'scanner/file.dart';

abstract class RustLibApiImplPlatform extends BaseApiImpl<RustLibWire> {
  RustLibApiImplPlatform({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @protected
  AnyhowException dco_decode_AnyhowException(dynamic raw);

  @protected
  RustStreamSink<CompareResult> dco_decode_StreamSink_compare_result_Sse(
      dynamic raw);

  @protected
  RustStreamSink<Event> dco_decode_StreamSink_event_Sse(dynamic raw);

  @protected
  String dco_decode_String(dynamic raw);

  @protected
  bool dco_decode_bool(dynamic raw);

  @protected
  CompareResult dco_decode_compare_result(dynamic raw);

  @protected
  Event dco_decode_event(dynamic raw);

  @protected
  File dco_decode_file(dynamic raw);

  @protected
  List<File> dco_decode_list_file(dynamic raw);

  @protected
  List<List<File>> dco_decode_list_list_file(dynamic raw);

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw);

  @protected
  OperationResult dco_decode_operation_result(dynamic raw);

  @protected
  BigInt dco_decode_u_64(dynamic raw);

  @protected
  int dco_decode_u_8(dynamic raw);

  @protected
  void dco_decode_unit(dynamic raw);

  @protected
  AnyhowException sse_decode_AnyhowException(SseDeserializer deserializer);

  @protected
  RustStreamSink<CompareResult> sse_decode_StreamSink_compare_result_Sse(
      SseDeserializer deserializer);

  @protected
  RustStreamSink<Event> sse_decode_StreamSink_event_Sse(
      SseDeserializer deserializer);

  @protected
  String sse_decode_String(SseDeserializer deserializer);

  @protected
  bool sse_decode_bool(SseDeserializer deserializer);

  @protected
  CompareResult sse_decode_compare_result(SseDeserializer deserializer);

  @protected
  Event sse_decode_event(SseDeserializer deserializer);

  @protected
  File sse_decode_file(SseDeserializer deserializer);

  @protected
  List<File> sse_decode_list_file(SseDeserializer deserializer);

  @protected
  List<List<File>> sse_decode_list_list_file(SseDeserializer deserializer);

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer);

  @protected
  OperationResult sse_decode_operation_result(SseDeserializer deserializer);

  @protected
  BigInt sse_decode_u_64(SseDeserializer deserializer);

  @protected
  int sse_decode_u_8(SseDeserializer deserializer);

  @protected
  void sse_decode_unit(SseDeserializer deserializer);

  @protected
  int sse_decode_i_32(SseDeserializer deserializer);

  @protected
  void sse_encode_AnyhowException(
      AnyhowException self, SseSerializer serializer);

  @protected
  void sse_encode_StreamSink_compare_result_Sse(
      RustStreamSink<CompareResult> self, SseSerializer serializer);

  @protected
  void sse_encode_StreamSink_event_Sse(
      RustStreamSink<Event> self, SseSerializer serializer);

  @protected
  void sse_encode_String(String self, SseSerializer serializer);

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer);

  @protected
  void sse_encode_compare_result(CompareResult self, SseSerializer serializer);

  @protected
  void sse_encode_event(Event self, SseSerializer serializer);

  @protected
  void sse_encode_file(File self, SseSerializer serializer);

  @protected
  void sse_encode_list_file(List<File> self, SseSerializer serializer);

  @protected
  void sse_encode_list_list_file(
      List<List<File>> self, SseSerializer serializer);

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer);

  @protected
  void sse_encode_operation_result(
      OperationResult self, SseSerializer serializer);

  @protected
  void sse_encode_u_64(BigInt self, SseSerializer serializer);

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer);

  @protected
  void sse_encode_unit(void self, SseSerializer serializer);

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer);
}

// Section: wire_class

class RustLibWire implements BaseWire {
  RustLibWire.fromExternalLibrary(ExternalLibrary lib);
}

@JS('wasm_bindgen')
external RustLibWasmModule get wasmModule;

@JS()
@anonymous
extension type RustLibWasmModule._(JSObject _) implements JSObject {}
