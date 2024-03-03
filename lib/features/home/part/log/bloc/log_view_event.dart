part of 'log_view_bloc.dart';

abstract class LogViewEvent extends Equatable {
  const LogViewEvent();
}

class LoadLogViewDataEvent extends LogViewEvent {
  @override
  List<Object?> get props => <Object>[];
}
