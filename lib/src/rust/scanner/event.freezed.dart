// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResEvent {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScannerEvent field0) scannerEvent,
    required TResult Function(CompareEvent field0) compareEvent,
    required TResult Function(DoneEvent field0) doneEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ScannerEvent field0)? scannerEvent,
    TResult? Function(CompareEvent field0)? compareEvent,
    TResult? Function(DoneEvent field0)? doneEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScannerEvent field0)? scannerEvent,
    TResult Function(CompareEvent field0)? compareEvent,
    TResult Function(DoneEvent field0)? doneEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResEvent_ScannerEvent value) scannerEvent,
    required TResult Function(ResEvent_CompareEvent value) compareEvent,
    required TResult Function(ResEvent_DoneEvent value) doneEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResEvent_ScannerEvent value)? scannerEvent,
    TResult? Function(ResEvent_CompareEvent value)? compareEvent,
    TResult? Function(ResEvent_DoneEvent value)? doneEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResEvent_ScannerEvent value)? scannerEvent,
    TResult Function(ResEvent_CompareEvent value)? compareEvent,
    TResult Function(ResEvent_DoneEvent value)? doneEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResEventCopyWith<$Res> {
  factory $ResEventCopyWith(ResEvent value, $Res Function(ResEvent) then) =
      _$ResEventCopyWithImpl<$Res, ResEvent>;
}

/// @nodoc
class _$ResEventCopyWithImpl<$Res, $Val extends ResEvent>
    implements $ResEventCopyWith<$Res> {
  _$ResEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ResEvent_ScannerEventImplCopyWith<$Res> {
  factory _$$ResEvent_ScannerEventImplCopyWith(
          _$ResEvent_ScannerEventImpl value,
          $Res Function(_$ResEvent_ScannerEventImpl) then) =
      __$$ResEvent_ScannerEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ScannerEvent field0});
}

/// @nodoc
class __$$ResEvent_ScannerEventImplCopyWithImpl<$Res>
    extends _$ResEventCopyWithImpl<$Res, _$ResEvent_ScannerEventImpl>
    implements _$$ResEvent_ScannerEventImplCopyWith<$Res> {
  __$$ResEvent_ScannerEventImplCopyWithImpl(_$ResEvent_ScannerEventImpl _value,
      $Res Function(_$ResEvent_ScannerEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$ResEvent_ScannerEventImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as ScannerEvent,
    ));
  }
}

/// @nodoc

class _$ResEvent_ScannerEventImpl extends ResEvent_ScannerEvent {
  const _$ResEvent_ScannerEventImpl(this.field0) : super._();

  @override
  final ScannerEvent field0;

  @override
  String toString() {
    return 'ResEvent.scannerEvent(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResEvent_ScannerEventImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResEvent_ScannerEventImplCopyWith<_$ResEvent_ScannerEventImpl>
      get copyWith => __$$ResEvent_ScannerEventImplCopyWithImpl<
          _$ResEvent_ScannerEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScannerEvent field0) scannerEvent,
    required TResult Function(CompareEvent field0) compareEvent,
    required TResult Function(DoneEvent field0) doneEvent,
  }) {
    return scannerEvent(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ScannerEvent field0)? scannerEvent,
    TResult? Function(CompareEvent field0)? compareEvent,
    TResult? Function(DoneEvent field0)? doneEvent,
  }) {
    return scannerEvent?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScannerEvent field0)? scannerEvent,
    TResult Function(CompareEvent field0)? compareEvent,
    TResult Function(DoneEvent field0)? doneEvent,
    required TResult orElse(),
  }) {
    if (scannerEvent != null) {
      return scannerEvent(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResEvent_ScannerEvent value) scannerEvent,
    required TResult Function(ResEvent_CompareEvent value) compareEvent,
    required TResult Function(ResEvent_DoneEvent value) doneEvent,
  }) {
    return scannerEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResEvent_ScannerEvent value)? scannerEvent,
    TResult? Function(ResEvent_CompareEvent value)? compareEvent,
    TResult? Function(ResEvent_DoneEvent value)? doneEvent,
  }) {
    return scannerEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResEvent_ScannerEvent value)? scannerEvent,
    TResult Function(ResEvent_CompareEvent value)? compareEvent,
    TResult Function(ResEvent_DoneEvent value)? doneEvent,
    required TResult orElse(),
  }) {
    if (scannerEvent != null) {
      return scannerEvent(this);
    }
    return orElse();
  }
}

abstract class ResEvent_ScannerEvent extends ResEvent {
  const factory ResEvent_ScannerEvent(final ScannerEvent field0) =
      _$ResEvent_ScannerEventImpl;
  const ResEvent_ScannerEvent._() : super._();

  @override
  ScannerEvent get field0;

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResEvent_ScannerEventImplCopyWith<_$ResEvent_ScannerEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResEvent_CompareEventImplCopyWith<$Res> {
  factory _$$ResEvent_CompareEventImplCopyWith(
          _$ResEvent_CompareEventImpl value,
          $Res Function(_$ResEvent_CompareEventImpl) then) =
      __$$ResEvent_CompareEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CompareEvent field0});
}

/// @nodoc
class __$$ResEvent_CompareEventImplCopyWithImpl<$Res>
    extends _$ResEventCopyWithImpl<$Res, _$ResEvent_CompareEventImpl>
    implements _$$ResEvent_CompareEventImplCopyWith<$Res> {
  __$$ResEvent_CompareEventImplCopyWithImpl(_$ResEvent_CompareEventImpl _value,
      $Res Function(_$ResEvent_CompareEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$ResEvent_CompareEventImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as CompareEvent,
    ));
  }
}

/// @nodoc

class _$ResEvent_CompareEventImpl extends ResEvent_CompareEvent {
  const _$ResEvent_CompareEventImpl(this.field0) : super._();

  @override
  final CompareEvent field0;

  @override
  String toString() {
    return 'ResEvent.compareEvent(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResEvent_CompareEventImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResEvent_CompareEventImplCopyWith<_$ResEvent_CompareEventImpl>
      get copyWith => __$$ResEvent_CompareEventImplCopyWithImpl<
          _$ResEvent_CompareEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScannerEvent field0) scannerEvent,
    required TResult Function(CompareEvent field0) compareEvent,
    required TResult Function(DoneEvent field0) doneEvent,
  }) {
    return compareEvent(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ScannerEvent field0)? scannerEvent,
    TResult? Function(CompareEvent field0)? compareEvent,
    TResult? Function(DoneEvent field0)? doneEvent,
  }) {
    return compareEvent?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScannerEvent field0)? scannerEvent,
    TResult Function(CompareEvent field0)? compareEvent,
    TResult Function(DoneEvent field0)? doneEvent,
    required TResult orElse(),
  }) {
    if (compareEvent != null) {
      return compareEvent(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResEvent_ScannerEvent value) scannerEvent,
    required TResult Function(ResEvent_CompareEvent value) compareEvent,
    required TResult Function(ResEvent_DoneEvent value) doneEvent,
  }) {
    return compareEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResEvent_ScannerEvent value)? scannerEvent,
    TResult? Function(ResEvent_CompareEvent value)? compareEvent,
    TResult? Function(ResEvent_DoneEvent value)? doneEvent,
  }) {
    return compareEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResEvent_ScannerEvent value)? scannerEvent,
    TResult Function(ResEvent_CompareEvent value)? compareEvent,
    TResult Function(ResEvent_DoneEvent value)? doneEvent,
    required TResult orElse(),
  }) {
    if (compareEvent != null) {
      return compareEvent(this);
    }
    return orElse();
  }
}

abstract class ResEvent_CompareEvent extends ResEvent {
  const factory ResEvent_CompareEvent(final CompareEvent field0) =
      _$ResEvent_CompareEventImpl;
  const ResEvent_CompareEvent._() : super._();

  @override
  CompareEvent get field0;

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResEvent_CompareEventImplCopyWith<_$ResEvent_CompareEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResEvent_DoneEventImplCopyWith<$Res> {
  factory _$$ResEvent_DoneEventImplCopyWith(_$ResEvent_DoneEventImpl value,
          $Res Function(_$ResEvent_DoneEventImpl) then) =
      __$$ResEvent_DoneEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DoneEvent field0});
}

/// @nodoc
class __$$ResEvent_DoneEventImplCopyWithImpl<$Res>
    extends _$ResEventCopyWithImpl<$Res, _$ResEvent_DoneEventImpl>
    implements _$$ResEvent_DoneEventImplCopyWith<$Res> {
  __$$ResEvent_DoneEventImplCopyWithImpl(_$ResEvent_DoneEventImpl _value,
      $Res Function(_$ResEvent_DoneEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$ResEvent_DoneEventImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as DoneEvent,
    ));
  }
}

/// @nodoc

class _$ResEvent_DoneEventImpl extends ResEvent_DoneEvent {
  const _$ResEvent_DoneEventImpl(this.field0) : super._();

  @override
  final DoneEvent field0;

  @override
  String toString() {
    return 'ResEvent.doneEvent(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResEvent_DoneEventImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResEvent_DoneEventImplCopyWith<_$ResEvent_DoneEventImpl> get copyWith =>
      __$$ResEvent_DoneEventImplCopyWithImpl<_$ResEvent_DoneEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ScannerEvent field0) scannerEvent,
    required TResult Function(CompareEvent field0) compareEvent,
    required TResult Function(DoneEvent field0) doneEvent,
  }) {
    return doneEvent(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ScannerEvent field0)? scannerEvent,
    TResult? Function(CompareEvent field0)? compareEvent,
    TResult? Function(DoneEvent field0)? doneEvent,
  }) {
    return doneEvent?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ScannerEvent field0)? scannerEvent,
    TResult Function(CompareEvent field0)? compareEvent,
    TResult Function(DoneEvent field0)? doneEvent,
    required TResult orElse(),
  }) {
    if (doneEvent != null) {
      return doneEvent(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResEvent_ScannerEvent value) scannerEvent,
    required TResult Function(ResEvent_CompareEvent value) compareEvent,
    required TResult Function(ResEvent_DoneEvent value) doneEvent,
  }) {
    return doneEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResEvent_ScannerEvent value)? scannerEvent,
    TResult? Function(ResEvent_CompareEvent value)? compareEvent,
    TResult? Function(ResEvent_DoneEvent value)? doneEvent,
  }) {
    return doneEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResEvent_ScannerEvent value)? scannerEvent,
    TResult Function(ResEvent_CompareEvent value)? compareEvent,
    TResult Function(ResEvent_DoneEvent value)? doneEvent,
    required TResult orElse(),
  }) {
    if (doneEvent != null) {
      return doneEvent(this);
    }
    return orElse();
  }
}

abstract class ResEvent_DoneEvent extends ResEvent {
  const factory ResEvent_DoneEvent(final DoneEvent field0) =
      _$ResEvent_DoneEventImpl;
  const ResEvent_DoneEvent._() : super._();

  @override
  DoneEvent get field0;

  /// Create a copy of ResEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResEvent_DoneEventImplCopyWith<_$ResEvent_DoneEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
