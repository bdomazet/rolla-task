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

class SearchResultState extends ProductsViewState {
  const SearchResultState({required this.productModel});
  final ProductModel? productModel;
  @override
  List<Object?> get props => <Object>[];
}

class LoaderState extends ProductsViewState {
  @override
  List<Object?> get props => <Object>[];
}

class AddMoreProductPartsState extends ProductsViewState {
  const AddMoreProductPartsState(
      {required this.skip, required this.products, required this.nextPageKey});
  final int skip;
  final int nextPageKey;
  final List<Products> products;
  @override
  List<Object?> get props => <Object>[];
}

class LastPartProductState extends ProductsViewState {
  const LastPartProductState({required this.skip, required this.products});
  final int skip;
  final List<Products> products;
  @override
  List<Object?> get props => <Object>[];
}
