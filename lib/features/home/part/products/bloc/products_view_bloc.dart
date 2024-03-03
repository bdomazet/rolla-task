import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/enums/my_http_method.dart';
import '../../../../../core/models/products_model.dart';
import '../../../../../core/services/network_service.dart';

part 'products_view_event.dart';
part 'products_view_state.dart';

class ProductsViewBloc extends Bloc<ProductsViewEvent, ProductsViewState> {
  ProductsViewBloc({required this.networkService})
      : super(ProductsViewInitialState()) {
    on<LoadProductsEvent>(onLoadProducts);
    on<ReloadAllProductsEvent>(onReloadAllProductsEvent);
    on<SearchProducts>(onSearchProducts, transformer:
        (Stream<SearchProducts> event,
            Stream<SearchProducts> Function(SearchProducts) mapper) {
      return event
          .debounceTime(const Duration(milliseconds: 500))
          .asyncExpand(mapper);
    });
  }

  NetworkService networkService;

  FutureOr<void> onLoadProducts(
      LoadProductsEvent event, Emitter<ProductsViewState> emit) async {
    ProductModel? productModel;
    await networkService
        .httpRequest(
            url: '$baseURL/auth/products?limit=$pageSize&skip=${event.skip}',
            method: MyHttpMethod.get)
        .then((dynamic value) {
      productModel = ProductModel.fromJson(value as Map<String, dynamic>);
    });
    if (productModel?.products != null &&
        productModel?.products?.length != null) {
      final int productModelLength = productModel?.products?.length ?? 0;
      final bool isLastPage = productModelLength < pageSize;
      final int nextPageKey = event.pageKey + productModel!.products!.length;
      if (isLastPage) {
        emit(LastPartProductState(productModel: productModel));
      } else {
        emit(AddMoreProductPartsState(
            productModel: productModel, nextPageKey: nextPageKey));
      }
    }
  }

  FutureOr<void> onReloadAllProductsEvent(
      ReloadAllProductsEvent event, Emitter<ProductsViewState> emit) {
    add(const LoadProductsEvent(limit: pageSize, skip: 0, pageKey: 0));
  }

  FutureOr<void> onSearchProducts(
      SearchProducts event, Emitter<ProductsViewState> emit) async {
    emit(LoaderState());
    ProductModel? productModel;
    await networkService
        .httpRequest(
            url: '$baseURL/auth/products/search?q=${event.searchInput}',
            method: MyHttpMethod.get)
        .then((dynamic value) {
      productModel = ProductModel.fromJson(value as Map<String, dynamic>);
    });
    if (productModel != null) {
      emit(ProductsLoadedState(productModel: productModel));
    }
  }
}
