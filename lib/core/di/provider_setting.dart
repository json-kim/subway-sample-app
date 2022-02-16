import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:subway_app/data/data_source/arrival_api_data_source.dart';
import 'package:subway_app/data/repository/arrival_repository_impl.dart';
import 'package:subway_app/domain/repository/arrival_repository.dart';
import 'package:subway_app/domain/usecase/load_arrival_data_use_case.dart';
import 'package:subway_app/presentation/subway_home/subway_home_view_model.dart';

final List<SingleChildWidget> globalProviders = [
  ...independentProviders,
  ...dependentProviders,
  ...changeNotifiers,
];

final List<SingleChildWidget> independentProviders = [
  // data source
  Provider(create: (context) => ArrivalApiDataSource()),
];

final List<SingleChildWidget> dependentProviders = [
  // repository
  ProxyProvider<ArrivalApiDataSource, ArrivalRepository>(
      update: (context, dataSource, _) => ArrivalRepositoryImpl(dataSource)),

  // usecase
  ProxyProvider<ArrivalRepository, LoadArrivalDataUseCase>(
      update: (context, repository, _) => LoadArrivalDataUseCase(repository)),
];

final List<SingleChildWidget> changeNotifiers = [
  // viewmodel
  ChangeNotifierProvider<SubwayHomeViewModel>(
      create: (context) =>
          SubwayHomeViewModel(context.read<LoadArrivalDataUseCase>())),
];
