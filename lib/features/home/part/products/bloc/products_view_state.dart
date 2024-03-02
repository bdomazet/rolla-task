part of 'products_view_bloc.dart';

abstract class ProductsViewState extends Equatable {
  const ProductsViewState();
}

class ProductsViewInitialState extends ProductsViewState {
  @override
  List<Object> get props => <Object>[];
}

class ProductsLoadedState extends ProductsViewState {
  const ProductsLoadedState({required this.productModel});
  final ProductModel? productModel;
  @override
  List<Object?> get props => <Object>[];
}

class LoaderState extends ProductsViewState {
  @override
  List<Object?> get props => <Object>[];
}
