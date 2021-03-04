import 'package:get_it/get_it.dart';
import 'package:crimyo/services/local_notification.dart';

GetIt _getIt = GetIt.instance;

setupLocators() {
  _getIt.registerLazySingleton(() => LocalNotification());
}