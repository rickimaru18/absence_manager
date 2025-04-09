import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../../../domain/domain.dart';

part 'home_page_state.freezed.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(<Absence>[]) List<Absence> absences,
    AbsenceFilter? filter,
    Failure? error,
    @Default(0) int offset,
    @Default(false) bool isLoading,
    @Default(true) bool hasNextPage,
  }) = _HomePageState;
}
