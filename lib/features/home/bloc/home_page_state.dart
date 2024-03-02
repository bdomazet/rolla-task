part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  @override
  List<Object> get props => <Object>[];
}

class ProductsTabViewState extends HomePageState {
  @override
  List<Object> get props => <Object>[];
}

class LogTabViewState extends HomePageState {
  @override
  List<Object> get props => <Object>[];
}

// class ProductsLoadedState extends HomePageState {
//   ProductModel productModel;
//   @override
//   List<Object> get props => <Object>[];
// }
