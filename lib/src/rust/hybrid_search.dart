// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.5.1.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class HybridSearchDetail {
  final String path;
  final BigInt createdEpoch;
  final BigInt modifiedEpoch;

  const HybridSearchDetail({
    required this.path,
    required this.createdEpoch,
    required this.modifiedEpoch,
  });

  @override
  int get hashCode =>
      path.hashCode ^ createdEpoch.hashCode ^ modifiedEpoch.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HybridSearchDetail &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          createdEpoch == other.createdEpoch &&
          modifiedEpoch == other.modifiedEpoch;
}

enum SearchType {
  and,
  or,
  ;
}