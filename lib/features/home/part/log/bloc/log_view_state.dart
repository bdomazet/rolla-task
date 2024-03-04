part of 'log_view_bloc.dart';

abstract class LogViewState extends Equatable {
  const LogViewState();
}

class LogViewInitialState extends LogViewState {
  @override
  List<Object> get props => <Object>[];
}

class LoaderState extends LogViewState {
  @override
  List<Object?> get props => <Object>[];
}

class DataLoadedState extends LogViewState {
  const DataLoadedState({required this.logModel});
  final List<LogModel> logModel;
  @override
  List<Object?> get props => <Object>[];
}
