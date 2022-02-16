import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/arrival.dart';

part 'subway_home_state.freezed.dart';

@freezed
class SubwayHomeState with _$SubwayHomeState {
  const factory SubwayHomeState({
    @Default([]) List<Arrival> arrivalList,
    @Default('매교') String station,
    @Default(false) bool isLoading,
  }) = _SubwayHomeState;
}
