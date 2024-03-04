import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/enums/my_http_method.dart';
import '../../../../../core/models/log_model.dart';
import '../../../../../core/services/network_service.dart';

part 'log_view_event.dart';
part 'log_view_state.dart';

class LogViewBloc extends Bloc<LogViewEvent, LogViewState> {
  LogViewBloc({required this.networkService}) : super(LogViewInitialState()) {
    on<LoadLogViewDataEvent>(onLoadViewEvent);
  }

  NetworkService networkService;
  final List<LogModel> logModelList = <LogModel>[];

  FutureOr<void> onLoadViewEvent(
      LogViewEvent event, Emitter<LogViewState> emit) async {
    emit(LoaderState());
    final ReceivePort receivePortLocal = ReceivePort();
    final RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if (rootIsolateToken == null) {
      print('Cannot get the RootIsolateToken');
      return;
    }

    try {
      final dynamic result = await networkService.httpRequest(
          url: largeJsonURL, method: MyHttpMethod.getLargeFile);

      await Isolate.spawn(parseLocalJson, <Object>[
        rootIsolateToken,
        receivePortLocal.sendPort,
        result.toString()
      ]);
      receivePortLocal.listen((dynamic data) async {
        logModelList.addAll(data as List<LogModel>);
      });
    } catch (e) {
      print('----');
      print(e);
    }
    await Future<void>.delayed(const Duration(seconds: 3));
    emit(DataLoadedState(logModel: logModelList));
  }
}

Future<List<LogModel>> parseLocalJson(List<dynamic> args) async {
  final RootIsolateToken rootIsolateToken = args[0] as RootIsolateToken;
  final SendPort sendPort = args[1] as SendPort;
  final String jsonString = args[2] as String;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  final List<Map<String, dynamic>> parsed =
      (jsonDecode(jsonString) as List<dynamic>).cast<Map<String, dynamic>>();
  final List<LogModel> logs = parsed
      .map<LogModel>((Map<String, dynamic> json) => LogModel.fromJson(json))
      .toList();
  sendPort.send(logs);
  return logs;
}
