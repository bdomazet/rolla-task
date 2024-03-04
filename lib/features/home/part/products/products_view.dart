import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/const/const.dart';
import '../../../../core/models/products.dart';
import '../../../../core/widgets/loader.dart';
import '../../../../core/widgets/my_text_field.dart';
import '../../../../injection_container.dart';
import 'bloc/products_view_bloc.dart';
import 'widgets/product_item.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final TextEditingController searchController = TextEditingController();

  late final PagingController<int, Products> _pagingController =
      PagingController<int, Products>(firstPageKey: 0);
  int skip = 0;

  @override
  void dispose() {
    _pagingController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pagingController.addPageRequestListener((int pageKey) {
      LoadProductsEvent(limit: pageSize, skip: skip, pageKey: pageKey);
    });
    return BlocProvider<ProductsViewBloc>(
      create: (BuildContext context) {
        return getIt<ProductsViewBloc>()
          ..add(const LoadProductsEvent(limit: pageSize, skip: 0, pageKey: 0));
      },
      child: Container(
        color: Colors.grey[100],
        child: BlocConsumer<ProductsViewBloc, ProductsViewState>(
          listener: (BuildContext context, ProductsViewState state) {
            if (state is AddMoreProductPartsState) {
              _pagingController.appendPage(state.products, state.nextPageKey);
            }
            if (state is LastPartProductState) {
              _pagingController.appendLastPage(state.products);
              skip = state.skip;
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
                    PagedListView<int, Products>(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Products>(
                        itemBuilder:
                            (BuildContext context, Products item, int index) =>
                                ProductItem(item: item),
                      ),
                    )
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
