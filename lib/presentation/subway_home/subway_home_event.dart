import 'package:freezed_annotation/freezed_annotation.dart';

part 'subway_home_event.freezed.dart';

@freezed
class SubwayHomeEvent with _$SubwayHomeEvent {
  const factory SubwayHomeEvent.loadArrival({@Default('매교') String station}) =
      LoadArrival;
}
