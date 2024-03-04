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

part 'log_view_state.dart';

class LogViewCubit extends Cubit<LogViewState> {
  LogViewCubit({required this.networkService}) : super(LogViewInitialState());

  NetworkService networkService;
  final List<LogModel> logModelList = <LogModel>[];

  FutureOr<void> onLoadViewEvent() async {
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
    } catch (e) {
      print('----');
      print(e);
    }
    receivePortLocal.listen((dynamic data) async {
      emit(DataLoadedState(logModel: data as List<LogModel>));
    });
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
