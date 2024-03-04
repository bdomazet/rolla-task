import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/network_service.dart';
import '../../../core/widgets/image_placeholder.dart';
import '../../../injection_container.dart';
import '../bloc/home_page_bloc.dart';
import '../part/log/log_view.dart';
import '../part/products/products_view.dart';
import '../widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      create: (BuildContext context) =>
          HomePageBloc()..add(ProductsTabPressedEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          title: Text(
            'Rolla Task',
            style: TextStyle(color: Colors.grey[700]),
          ),
          elevation: 0,
          backgroundColor: Colors.grey[100],
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImagePlaceholder(
                imagePath: getIt<NetworkService>().currentUser?.image,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (BuildContext context, HomePageState state) {
            if (state is ProductsTabViewState) {
              return const ProductsView();
            } else if (state is LogTabViewState) {
              return const LogView();
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      // avatar
                      'Rolla task',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (BuildContext context, HomePageState state) {
            return NavBar(onPressedProductsTab: () {
              context.read<HomePageBloc>().add(ProductsTabPressedEvent());
            }, onPressedLogTab: () {
              context.read<HomePageBloc>().add(LogTabPressedEvent());
            });
          },
        ),
      ),
    );
  }
}
