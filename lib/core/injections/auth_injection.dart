//
// import 'package:openkm_mobile/features/auth/data/data_sources/location_remote_data_source.dart';
// import 'package:openkm_mobile/features/auth/data/repositories/auth_repo_impl.dart';
// import 'package:openkm_mobile/features/auth/domain/repositories/auth_repo.dart';
// import 'package:openkm_mobile/features/auth/domain/usecases/login_usecase.dart';
// import 'package:openkm_mobile/features/auth/presentation/bloc/auth_bloc.dart';
//
// import 'init.dart';
//
// Future<void> init() async {
//   //! Bloc
//   sl.registerFactory(() => AuthBloc(sl()));
//
//   //! Usecases
//   sl.registerLazySingleton(() => LoginUseCase(sl()));
//   sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl(), sl()));
//
//   //! Data Sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//       () => AuthRemoteDataSourceImpl(sl()));
// }
