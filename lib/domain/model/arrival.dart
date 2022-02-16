import 'package:freezed_annotation/freezed_annotation.dart';

part 'arrival.freezed.dart';

part 'arrival.g.dart';

@freezed
class Arrival with _$Arrival {
  const factory Arrival({
    required String subwayId, // 호선 ID
    required String updnLine, // 상하행선 구분
    required String trainLineNm, // 도착지 방면
    required String subwayHeading, // 내리는문 방향
    required String statnFid, // 이전 지하철역 ID
    required String statnTid, // 다음 지하철역 ID
    required String statnId, // 지하철역 ID
    required String statnNm, // 지하철역 명
    required String ordkey, // 도착열차 순번
    required String subwayList, // 연계 호선ID ,로 구분된 스트링
    required String statnList, // 연계 지하열역 ID ,로 구분된 스트링
    required String? btrainSttus, // 열차 종료
    required String barvlDt, // 초 단위
    required String btrainNo, // 열차 번호
    required String bstatnId, // 종착역 ID
    required String bstatnNm, // 종착역 이름
    required String recptnDt, // 생성 시간
    required String arvlMsg2, // 도착 메시지2
    required String arvlMsg3, // 도착 메시지3
    required String arvlCd, // 도착 코드
  }) = _Arrival;

  factory Arrival.fromJson(Map<String, dynamic> json) =>
      _$ArrivalFromJson(json);
}
