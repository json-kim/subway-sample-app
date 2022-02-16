import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_app/presentation/subway_home/subway_home_event.dart';
import 'package:subway_app/presentation/subway_home/subway_home_view_model.dart';

class SubwayHomeScreen extends StatefulWidget {
  const SubwayHomeScreen({Key? key}) : super(key: key);

  @override
  _SubwayHomeScreenState createState() => _SubwayHomeScreenState();
}

class _SubwayHomeScreenState extends State<SubwayHomeScreen> {
  final _textEditingController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<SubwayHomeViewModel>();

      _subscription = viewModel.uiEventStream.listen((event) {
        event.when(snackBar: (message) {
          final snackBar = SnackBar(content: Text(message));

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        });
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SubwayHomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: Text('${state.station}역 지하철 도착 정보'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _textEditingController,
                ),
              ),
              IconButton(
                  onPressed: () {
                    final station = _textEditingController.text;
                    viewModel
                        .onEvent(SubwayHomeEvent.loadArrival(station: station));
                  },
                  icon: const Icon(Icons.search_outlined)),
            ],
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    itemCount: state.arrivalList.length,
                    itemBuilder: (context, idx) {
                      final arrival = state.arrivalList[idx];
                      final minutes = DateTime.now()
                          .difference(DateTime.parse(arrival.recptnDt))
                          .inMinutes;

                      return Column(
                        children: [
                          Expanded(
                              child: Image.network(
                                  'https://cdn.pixabay.com/photo/2017/02/01/10/56/berlin-2029629_1280.png')),
                          Text(arrival.trainLineNm),
                          Text(arrival.updnLine),
                          Text('종착역 : ${arrival.bstatnNm}'),
                          Text('현재 : ${arrival.arvlMsg2}'),
                          Text(minutes == 0 ? '곧 도착' : '$minutes 분전'),
                        ],
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
