part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class ProductsTabPressedEvent extends HomePageEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class LogTabPressedEvent extends HomePageEvent {
  @override
  List<Object?> get props => <Object?>[];
}
