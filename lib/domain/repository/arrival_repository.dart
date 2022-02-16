import 'package:subway_app/domain/model/arrival.dart';

import '../../core/result/result.dart';

abstract class ArrivalRepository {
  Future<Result<List<Arrival>>> getArrivalData(String station);
}
