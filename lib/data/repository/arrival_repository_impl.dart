import 'package:subway_app/core/result/result.dart';
import 'package:subway_app/data/data_source/arrival_api_data_source.dart';
import 'package:subway_app/domain/model/arrival.dart';
import 'package:subway_app/domain/repository/arrival_repository.dart';

class ArrivalRepositoryImpl implements ArrivalRepository {
  final ArrivalApiDataSource _apiDataSource;

  ArrivalRepositoryImpl(this._apiDataSource);

  @override
  Future<Result<List<Arrival>>> getArrivalData(String station) async {
    final result = await _apiDataSource.requestArrivalData(station);

    return result.when(success: (jsonList) {
      try {
        final List<Arrival> arrivalList =
            jsonList.map((json) => Arrival.fromJson(json)).toList();

        return Result.success(arrivalList);
      } catch (e) {
        return Result.error('$runtimeType.getArrivalDate : 파싱 에러 발생 \n$e');
      }
    }, error: (message) {
      return Result.error(message);
    });
  }
}
