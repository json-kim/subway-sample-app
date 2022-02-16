import 'package:freezed_annotation/freezed_annotation.dart';

part 'subway_home_ui_event.freezed.dart';

@freezed
class SubwayHomeUiEvent with _$SubwayHomeUiEvent {
  const factory SubwayHomeUiEvent.snackBar(String message) = SnackBar;
}
