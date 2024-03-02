import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/enums/my_http_method.dart';
import '../../../../../core/models/products_model.dart';
import '../../../../../core/services/network_service.dart';
import '../../../../../injection_container.dart';

part 'products_view_event.dart';
part 'products_view_state.dart';

class ProductsViewBloc extends Bloc<ProductsViewEvent, ProductsViewState> {
  ProductsViewBloc() : super(ProductsViewInitialState()) {
    on<LoadProductsEvent>(onLoadProducts);
    on<ReloadAllProductsEvent>(onReloadAllProductsEvent);
    on<SearchProducts>(onSearchProducts,
        transformer: (Stream<SearchProducts> event, mapper) {
      return event
          .debounceTime(const Duration(milliseconds: 500))
          .asyncExpand(mapper);
    });
  }

  FutureOr<void> onLoadProducts(
      LoadProductsEvent event, Emitter<ProductsViewState> emit) async {
    ProductModel? productModel;
    await getIt<NetworkService>()
        .httpRequest(url: '$baseURL/auth/products', method: MyHttpMethod.get)
        .then((dynamic value) {
      productModel = ProductModel.fromJson(value as Map<String, dynamic>);
    });
    if (productModel != null) {
      emit(ProductsLoadedState(productModel: productModel));
    }
  }

  FutureOr<void> onReloadAllProductsEvent(
      ReloadAllProductsEvent event, Emitter<ProductsViewState> emit) {
    add(LoadProductsEvent());
  }

  FutureOr<void> onSearchProducts(
      SearchProducts event, Emitter<ProductsViewState> emit) async {
    emit(LoaderState());
    ProductModel? productModel;
    await getIt<NetworkService>()
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
