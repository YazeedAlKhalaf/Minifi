import 'package:get_it/get_it.dart';
import 'package:minifi_app/src/services/dialog_service.dart';
import 'package:minifi_app/src/services/navigation_service.dart';
import 'package:minifi_app/src/services/api_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => ApiService());
}
