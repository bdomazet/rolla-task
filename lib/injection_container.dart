import 'package:get_it/get_it.dart';

import 'core/services/network_service.dart';
import 'core/services/secure_storage_service.dart';
import 'features/auth/bloc/login_page_bloc.dart';
import 'features/home/bloc/home_page_bloc.dart';
import 'features/home/part/log/bloc/log_view_bloc.dart';
import 'features/home/part/products/bloc/products_view_bloc.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<NetworkService>(NetworkService());
  getIt.registerSingleton<SecureStorage>(SecureStorage());
  getIt.registerSingleton<LoginPageBloc>(LoginPageBloc());
  getIt.registerSingleton<HomePageBloc>(HomePageBloc());
  getIt.registerFactory(
      () => ProductsViewBloc(networkService: getIt<NetworkService>()));
  getIt.registerFactory(() => LogViewBloc());
}
