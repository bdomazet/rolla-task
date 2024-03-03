import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/const/const.dart';
import '../../../../core/models/products_model.dart';
import '../../../../core/widgets/loader.dart';
import '../../../../core/widgets/my_text_field.dart';
import '../../../../injection_container.dart';
import 'bloc/products_view_bloc.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final TextEditingController searchController = TextEditingController();

  late final PagingController<int, List<ProductModel>> _pagingController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsViewBloc>(
      create: (BuildContext context) {
        _pagingController =
            PagingController<int, List<ProductModel>>(firstPageKey: 0);
        return getIt<ProductsViewBloc>()
          ..add(const LoadProductsEvent(limit: pageSize, skip: 0, pageKey: 0));
      },
      child: Container(
        color: Colors.grey[100],
        child: BlocConsumer<ProductsViewBloc, ProductsViewState>(
          listener: (BuildContext context, ProductsViewState state) {
            if (state is AddMoreProductPartsState) {
              // _pagingController.appendPage(
              //     state.productModel! as List<List<ProductModel>>,
              //     state.nextPageKey);
            }
            if (state is LastPartProductState) {
              // _pagingController.appendLastPage(
              //     state.productModel! as List<List<ProductModel>>);
            }
          },
          builder: (BuildContext context, ProductsViewState state) {
            if (state is ProductsLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.h,
                    ),
                    MyTextField(
                      controller: searchController,
                      hintText: 'Search data',
                      onChanged: (String input) {
                        if (input.isEmpty) {
                          context
                              .read<ProductsViewBloc>()
                              .add(ReloadAllProductsEvent());
                        } else {
                          context.read<ProductsViewBloc>().add(SearchProducts(
                              searchInput: searchController.text));
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: const Divider(),
                    ),
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.productModel?.products?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                leading: Text(
                                  '${state.productModel?.products?[index].id}',
                                  style: TextStyle(color: Colors.grey[900]),
                                ),
                                title: Text(
                                  '${state.productModel?.products?[index].title}',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                subtitle: Text(
                                  '${state.productModel?.products?[index].brand}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: const Divider(),
                              ),
                            ],
                          );
                        }),
                    // PagedListView<int, ProductModel>(
                    //   pagingController: _pagingController,
                    //   builderDelegate: PagedChildBuilderDelegate<ProductModel>(
                    //     itemBuilder: (BuildContext context, ProductModel item,
                    //             int index) =>
                    //         Column(
                    //       children: <Widget>[
                    //         ListTile(
                    //           leading: Text(
                    //             '${item.products?[index].id}',
                    //             style: TextStyle(color: Colors.grey[900]),
                    //           ),
                    //           title: Text(
                    //             '${item.products?[index].title}',
                    //             style: TextStyle(color: Colors.grey[800]),
                    //           ),
                    //           subtitle: Text(
                    //             '${item.products?[index].brand}',
                    //             style: TextStyle(color: Colors.grey[700]),
                    //           ),
                    //         ),
                    //         Padding(
                    //           padding: EdgeInsets.symmetric(horizontal: 25.w),
                    //           child: const Divider(),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              );
            } else {
              return const Loader();
            }
          },
        ),
      ),
    );
  }
}
