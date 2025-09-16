//
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:openkm_mobile/core/constants/storage_service.dart';
// import 'package:openkm_mobile/core/injections/init.dart';
// import 'package:openkm_mobile/core/utils/network/network_checker.dart';
// import 'package:openkm_mobile/core/utils/network/network_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// Future<void> init() async {
//   sl.registerFactory<NetworkService>(() => NetworkServiceDio());
//   sl.registerFactory<StorageService>(() => StorageService());
//
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoInternetChecker(sl()));
//   //! External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => SharedPreferences.getInstance());
//   sl.registerLazySingleton<InternetConnectionChecker>(
//     () => InternetConnectionChecker.createInstance(),
//   );
// }
