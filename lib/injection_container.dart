import 'package:get_it/get_it.dart';

import 'core/services/network_service.dart';
import 'core/services/secure_storage_service.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<NetworkService>(NetworkService());
  getIt.registerSingleton<SecureStorage>(SecureStorage());
}
