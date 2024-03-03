part of 'products_view_bloc.dart';

abstract class ProductsViewEvent extends Equatable {
  const ProductsViewEvent();
}

class LoadProductsEvent extends ProductsViewEvent {
  const LoadProductsEvent({
    required this.limit,
    required this.skip,
    required this.pageKey,
  });
  final int limit;
  final int skip;
  final int pageKey;
  @override
  List<Object?> get props => <Object>[limit, skip, pageKey];
}

class ReloadAllProductsEvent extends ProductsViewEvent {
  @override
  List<Object?> get props => <Object>[];
}

class SearchProducts extends ProductsViewEvent {
  const SearchProducts({required this.searchInput});
  final String searchInput;
  @override
  List<Object?> get props => <Object>[searchInput];
}
