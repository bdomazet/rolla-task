import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<ProductsTabPressedEvent>(onProductsTabPressedEvent);
    on<LogTabPressedEvent>(onLogTabPressedEvent);
  }

  FutureOr<void> onProductsTabPressedEvent(
      ProductsTabPressedEvent event, Emitter<HomePageState> emit) async {
    emit(ProductsTabViewState());
  }

  FutureOr<void> onLogTabPressedEvent(
      LogTabPressedEvent event, Emitter<HomePageState> emit) {
    emit(LogTabViewState());
  }
}
