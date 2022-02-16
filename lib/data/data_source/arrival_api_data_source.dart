import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/result/result.dart';

class ArrivalApiDataSource {
  Future<Result<List>> requestArrivalData(String station) async {
    final String uri =
        'http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/$station';
    final response = await http.get(Uri.parse(uri));

    try {
      if (response.statusCode == 200) {
        final List arrivalJsonList =
            jsonDecode(response.body)['realtimeArrivalList'];

        return Result.success(arrivalJsonList);
      } else {
        return Result.error(
            '$runtimeType.requestArrivalData : ${response.statusCode} 네트워크 에러 ${response.statusCode}');
      }
    } catch (e) {
      return Result.error('$runtimeType.requestArrivalData : 네트워크 에러 발생 \n$e');
    }
  }
}
