import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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

  FutureOr<void> onLoadViewEvent(
      LogViewEvent event, Emitter<LogViewState> emit) async {
    emit(LoaderState());
    final RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if (rootIsolateToken == null) {
      print('Cannot get the RootIsolateToken');
      return;
    }

    try {
      final dynamic result = await networkService.httpRequest(
          url: largeJsonURL, method: MyHttpMethod.getLargeFile);
      final ReceivePort receivePortLocal = ReceivePort();
      await Isolate.spawn(parseLocalJson, <Object>[
        rootIsolateToken,
        receivePortLocal.sendPort,
        result.toString()
      ]);

      receivePortLocal.listen((dynamic data) async {
        print('success response');
        print(data);
      });

      // print('completed');
    } catch (e) {
      print('----');
      print(e);
    }
  }

  Future<List<LogModel>> newThreadParse(String value) {
    return compute(_decodeAndParseJson, value);
  }

  List<LogModel> parseLogModel(String value) {
    final List<Map<String, dynamic>> parsed =
        (jsonDecode(value) as List<dynamic>).cast<Map<String, dynamic>>();
    return parsed
        .map<LogModel>((Map<String, dynamic> json) => LogModel.fromJson(json))
        .toList();
  }

  // Future<List<SearchResult>> parseInBackground(String encodedJson) {
  //   // compute spawns an isolate, runs a callback on that isolate, and returns a Future with the result
  //   return compute(_decodeAndParseJson, encodedJson);
  // }

  List<LogModel> _decodeAndParseJson(String encodedJson) {
    final dynamic jsonData = jsonDecode(encodedJson);
    final List<dynamic> resultsJson = jsonData as List<dynamic>;
    return resultsJson
        .map<LogModel>(
            (dynamic json) => LogModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

Future<void> parseLocalJson(List<dynamic> args) async {
  final RootIsolateToken rootIsolateToken = args[0] as RootIsolateToken;
  final SendPort sendPort = args[1] as SendPort;
  final String jsonString = args[2] as String;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  // final json = jsonDecode(jsonString);
  final List<Map<String, dynamic>> parsed =
      (jsonDecode(jsonString) as List<dynamic>).cast<Map<String, dynamic>>();
  final List<LogModel> logs = parsed
      .map<LogModel>((Map<String, dynamic> json) => LogModel.fromJson(json))
      .toList();
  sendPort.send(logs);
}
