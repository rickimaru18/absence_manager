// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomePageState {
  List<Absence> get absences;
  AbsenceFilter? get filter;
  Failure? get error;
  int get offset;
  bool get isLoading;
  bool get hasNextPage;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      _$HomePageStateCopyWithImpl<HomePageState>(
          this as HomePageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomePageState &&
            const DeepCollectionEquality().equals(other.absences, absences) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(absences),
      filter,
      error,
      offset,
      isLoading,
      hasNextPage);

  @override
  String toString() {
    return 'HomePageState(absences: $absences, filter: $filter, error: $error, offset: $offset, isLoading: $isLoading, hasNextPage: $hasNextPage)';
  }
}

/// @nodoc
abstract mixin class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) _then) =
      _$HomePageStateCopyWithImpl;
  @useResult
  $Res call(
      {List<Absence> absences,
      AbsenceFilter? filter,
      Failure? error,
      int offset,
      bool isLoading,
      bool hasNextPage});
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._self, this._then);

  final HomePageState _self;
  final $Res Function(HomePageState) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? absences = null,
    Object? filter = freezed,
    Object? error = freezed,
    Object? offset = null,
    Object? isLoading = null,
    Object? hasNextPage = null,
  }) {
    return _then(_self.copyWith(
      absences: null == absences
          ? _self.absences
          : absences // ignore: cast_nullable_to_non_nullable
              as List<Absence>,
      filter: freezed == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as AbsenceFilter?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      offset: null == offset
          ? _self.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNextPage: null == hasNextPage
          ? _self.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _HomePageState implements HomePageState {
  const _HomePageState(
      {final List<Absence> absences = const <Absence>[],
      this.filter,
      this.error,
      this.offset = 0,
      this.isLoading = false,
      this.hasNextPage = true})
      : _absences = absences;

  final List<Absence> _absences;
  @override
  @JsonKey()
  List<Absence> get absences {
    if (_absences is EqualUnmodifiableListView) return _absences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_absences);
  }

  @override
  final AbsenceFilter? filter;
  @override
  final Failure? error;
  @override
  @JsonKey()
  final int offset;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasNextPage;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomePageStateCopyWith<_HomePageState> get copyWith =>
      __$HomePageStateCopyWithImpl<_HomePageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomePageState &&
            const DeepCollectionEquality().equals(other._absences, _absences) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_absences),
      filter,
      error,
      offset,
      isLoading,
      hasNextPage);

  @override
  String toString() {
    return 'HomePageState(absences: $absences, filter: $filter, error: $error, offset: $offset, isLoading: $isLoading, hasNextPage: $hasNextPage)';
  }
}

/// @nodoc
abstract mixin class _$HomePageStateCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$HomePageStateCopyWith(
          _HomePageState value, $Res Function(_HomePageState) _then) =
      __$HomePageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Absence> absences,
      AbsenceFilter? filter,
      Failure? error,
      int offset,
      bool isLoading,
      bool hasNextPage});
}

/// @nodoc
class __$HomePageStateCopyWithImpl<$Res>
    implements _$HomePageStateCopyWith<$Res> {
  __$HomePageStateCopyWithImpl(this._self, this._then);

  final _HomePageState _self;
  final $Res Function(_HomePageState) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? absences = null,
    Object? filter = freezed,
    Object? error = freezed,
    Object? offset = null,
    Object? isLoading = null,
    Object? hasNextPage = null,
  }) {
    return _then(_HomePageState(
      absences: null == absences
          ? _self._absences
          : absences // ignore: cast_nullable_to_non_nullable
              as List<Absence>,
      filter: freezed == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as AbsenceFilter?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      offset: null == offset
          ? _self.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNextPage: null == hasNextPage
          ? _self.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
