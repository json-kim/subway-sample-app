import 'dart:async';

import 'package:flutter/material.dart';
import 'package:subway_app/domain/usecase/load_arrival_data_use_case.dart';
import 'package:subway_app/presentation/subway_home/subway_home_state.dart';
import 'package:subway_app/presentation/subway_home/subway_home_ui_event.dart';

import 'subway_home_event.dart';

class SubwayHomeViewModel with ChangeNotifier {
  final LoadArrivalDataUseCase _loadArrivalDataUseCase;

  SubwayHomeViewModel(this._loadArrivalDataUseCase) {
    _loadArrival('매교');
  }

  SubwayHomeState _state = SubwayHomeState();
  SubwayHomeState get state => _state;

  final _uiEventController = StreamController<SubwayHomeUiEvent>.broadcast();
  Stream<SubwayHomeUiEvent> get uiEventStream => _uiEventController.stream;

  void onEvent(SubwayHomeEvent event) {
    event.when(loadArrival: _loadArrival);
  }

  Future<void> _loadArrival(String station) async {
    if (station.isEmpty) {
      station = '매교';
    }
    _state = _state.copyWith(isLoading: true, station: station);
    notifyListeners();

    final result = await _loadArrivalDataUseCase(station);

    result.when(success: (arrivalList) {
      _state = _state.copyWith(arrivalList: arrivalList);
    }, error: (message) {
      _state = _state.copyWith(arrivalList: []);
      debugPrint(message);
      _uiEventController.add(const SubwayHomeUiEvent.snackBar('정보 가져오기 실패'));
    });

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }
}
