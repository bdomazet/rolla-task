import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/loader.dart';
import '../../../../core/widgets/my_text_field.dart';
import 'bloc/products_view_bloc.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsViewBloc>(
      create: (BuildContext context) =>
          ProductsViewBloc()..add(LoadProductsEvent()),
      child: Container(
        color: Colors.grey[100],
        child: BlocBuilder<ProductsViewBloc, ProductsViewState>(
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
                                    '${state.productModel?.products?[index].id}'),
                                title: Text(
                                    '${state.productModel?.products?[index].title}'),
                                subtitle: Text(
                                    '${state.productModel?.products?[index].brand}'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: const Divider(),
                              ),
                            ],
                          );
                        }),
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
