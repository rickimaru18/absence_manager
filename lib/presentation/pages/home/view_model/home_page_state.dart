import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../../../domain/domain.dart';

part 'home_page_state.freezed.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(<Absence>[]) List<Absence> absences,
    Failure? error,
    @Default(false) bool isLoading,
  }) = _HomePageState;
}
