import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/models/log_model.dart';

part 'log_view_event.dart';
part 'log_view_state.dart';

class LogViewBloc extends Bloc<LogViewEvent, LogViewState> {
  LogViewBloc() : super(LogViewInitialState()) {
    on<LoadViewEvent>(onLoadViewEvent);
  }

  FutureOr<void> onLoadViewEvent(
      LogViewEvent event, Emitter<LogViewState> emit) async {
    emit(LoaderState());
    // List<LogModel?> logModel;
    // final Dio dio = Dio();
    // await dio
    //     .get(
    //   largeJsonURL,
    // )
    //     .then((dynamic value) {
    //   // final Map<String, dynamic> valueMap = value as Map<String, dynamic>;
    //   logModel = parseJson(logModel) as List<LogModel?>;
    //   if (logModel != null) {
    //     print(logModel?.actor);
    //   }
    // });

    // await getIt<NetworkService>()
    //     .httpRequest(url: largeJsonURL, method: MyHttpMethod.get)
    //     .then((dynamic value) {
    //   // final Map<String, dynamic> valueMap = value as Map<String, dynamic>;
    //   logModel = parseJson(value as Map<String, dynamic>) as LogModel?;
    //   if (logModel != null) {
    //     print(logModel?.actor);
    //   }
    // });
    // if (logModel != null) {
    //   emit(DataLoadedState(logModel: logModel));
    // }
  }

  // Future<LogModel?> parseJson(List<LogModel?> value) async {
  //   final LogModel? logModel = await compute(LogModel.fromJson, value);
  //   return logModel;
  // }
}
