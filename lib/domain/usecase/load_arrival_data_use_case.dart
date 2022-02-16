import '../../core/result/result.dart';
import '../model/arrival.dart';
import '../repository/arrival_repository.dart';

class LoadArrivalDataUseCase {
  final ArrivalRepository _arrivalRepository;

  LoadArrivalDataUseCase(this._arrivalRepository);

  Future<Result<List<Arrival>>> call(String station) async {
    final result = await _arrivalRepository.getArrivalData(station);

    return result.when(success: (arrivalList) {
      return Result.success(arrivalList);
    }, error: (message) {
      return Result.error(message);
    });
  }
}
